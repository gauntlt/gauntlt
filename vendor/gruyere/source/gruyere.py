#!/usr/bin/env python2.5

"""Gruyere - a web application with holes.

Copyright 2010 Google Inc. All rights reserved.

This code is licensed under the http://creativecommons.org/licenses/by-nd/3.0/us
Creative Commons Attribution-No Derivative Works 3.0 United States license.

DO NOT COPY THIS CODE!

This application is a small self-contained web application with numerous
security holes. It is provided for use with the Web Application Exploits and
Defenses codelab. You may modify the code for your own use while doing the
codelab but you may not distribute the modified code. Brief excerpts of this
code may be used for educational or instructional purposes provided this
notice is kept intact. By using Gruyere you agree to the Terms of Service
http://code.google.com/terms.html
"""

__author__ = 'Bruce Leban'

# system modules
from BaseHTTPServer import BaseHTTPRequestHandler
from BaseHTTPServer import HTTPServer
import cgi
import cPickle
import os
import socket
import sys
import threading
import traceback
import urllib
from urlparse import urlparse


try:
  sys.dont_write_bytecode = True
except AttributeError:
  pass

# our modules
import data
import gtl


DB_FILE = '/stored-data.txt'
SECRET_FILE = '/secret.txt'

INSTALL_PATH = '.'
RESOURCE_PATH = 'resources'

SPECIAL_COOKIE = '_cookie'
SPECIAL_PROFILE = '_profile'
SPECIAL_DB = '_db'
SPECIAL_PARAMS = '_params'
SPECIAL_UNIQUE_ID = '_unique_id'

COOKIE_UID = 'uid'
COOKIE_ADMIN = 'is_admin'
COOKIE_AUTHOR = 'is_author'


# Set to True to cause the server to exit after processing the current url.
quit_server = False

# A global copy of the database so that _GetDatabase can access it.
stored_data = None

# The HTTPServer object.
http_server = None

# A secret value used to generate hashes to protect cookies from tampering.
cookie_secret = ''

# File extensions of resource files that we recognize.
RESOURCE_CONTENT_TYPES = {
    '.css': 'text/css',
    '.gif': 'image/gif',
    '.htm': 'text/html',
    '.html': 'text/html',
    '.js': 'application/javascript',
    '.jpeg': 'image/jpeg',
    '.jpg': 'image/jpeg',
    '.png': 'image/png',
    '.ico': 'image/x-icon',
    '.text': 'text/plain',
    '.txt': 'text/plain',
}


def main():
  _SetWorkingDirectory()

  global quit_server
  quit_server = False

  # Normally, Gruyere only accepts connections to/from localhost. If you
  # would like to allow access from other ip addresses, you can change to
  # operate in a less secure mode. Set insecure_mode to True to serve on the
  # hostname instead of localhost and add the addresses of the other machines
  # to allowed_ips below.

  insecure_mode = False

  # WARNING! DO NOT CHANGE THE FOLLOWING SECTION OF CODE!

  # This application is very exploitable. It takes several precautions to
  # limit the risk from a real attacker:
  #   (1) Serve requests on localhost so that it will not be accessible
  # from other machines.
  #   (2) If a request is received from any IP other than localhost, quit.
  # (This protection is implemented in do_GET/do_POST.)
  #   (3) Inject a random identifier as the first part of the path and
  # quit if a request is received without this identifier (except for an
  # empty path which redirects and /favicon.ico).
  #   (4) Automatically exit after 2 hours (7200 seconds) to mitigate against
  # accidentally leaving the server running.

  quit_timer = threading.Timer(7200, lambda: _Exit('Timeout'))  # DO NOT CHANGE
  quit_timer.start()                                            # DO NOT CHANGE

  # The unique id is created from user- and machine-dependent data
  # that is different for each user/machine but unlikely to change
  # very frequently, making it hard to guess.

  cwd = os.getcwd()                                             # DO NOT CHANGE
  user_path = os.path.expanduser('~')                           # DO NOT CHANGE
  py_stat = os.stat(sys.executable)                             # DO NOT CHANGE
  this_stat = os.stat(cwd + '/gruyere.py')                      # DO NOT CHANGE
  user_stat = os.stat(user_path)                                # DO NOT CHANGE
  seed_value = (socket.gethostname(),                           # DO NOT CHANGE
                py_stat[0:7], py_stat[8:10],                    # DO NOT CHANGE
                    # skips [7] == last access time             # DO NOT CHANGE
                cwd,                                            # DO NOT CHANGE
                this_stat[0:7], this_stat[8:10],                # DO NOT CHANGE
                    # skips [7] == last access time             # DO NOT CHANGE
                user_path,                                      # DO NOT CHANGE
                user_stat[0:6], user_stat[8:10],                # DO NOT CHANGE
                    # skips [6:8] == size and last access time  # DO NOT CHANGE
                sys.version)                                    # DO NOT CHANGE

  if insecure_mode:                                             # DO NOT CHANGE
    server_name = os.popen('hostname').read().replace('\n','')  # DO NOT CHANGE
  else:                                                         # DO NOT CHANGE
    server_name = '127.0.0.1'                                   # DO NOT CHANGE
  server_port = 8008                                            # DO NOT CHANGE
  global server_unique_id                                       # DO NOT CHANGE
  server_unique_id = str(abs(hash(seed_value)))                 # DO NOT CHANGE

  # END WARNING!

  global http_server
  http_server = HTTPServer((server_name, server_port),
                           GruyereRequestHandler)

  print >>sys.stderr, '''
      Gruyere started...
          http://%s:%d/
          http://%s:%d/%s/''' % (
      server_name, server_port, server_name, server_port, server_unique_id)

  global stored_data
  stored_data = _LoadDatabase()

  while not quit_server:
    http_server.handle_request()
    _SaveDatabase(stored_data)

  print >>sys.stderr, '\nClosing'
  http_server.socket.close()
  _Exit('quit_server')


def _Exit(reason):
  # use os._exit instead of sys.exit because this can't be trapped
  print >>sys.stderr, '\nExit: ' + reason
  os._exit(0)


def _SetWorkingDirectory():
  """Set the working directory to the directory containing this file."""
  if sys.path[0]:
    os.chdir(sys.path[0])


def _LoadDatabase():
  """Load the database from stored-data.txt.

  Returns:
    The loaded database.
  """

  try:
    f = _Open(INSTALL_PATH, DB_FILE)
    stored_data = cPickle.load(f)
    f.close()
  except (IOError, ValueError):
    _Log('Couldn\'t load data; expected the first time Gruyere is run')
    stored_data = None

  f = _Open(INSTALL_PATH, SECRET_FILE)
  global cookie_secret
  cookie_secret = f.readline()
  f.close()

  return stored_data


def _SaveDatabase(save_database):
  """Save the database to stored-data.txt.

  Args:
    save_database: the database to save.
  """

  try:
    f = _Open(INSTALL_PATH, DB_FILE, 'w')
    cPickle.dump(save_database, f)
    f.close()
  except IOError:
    _Log('Couldn\'t save data')


def _Open(location, filename, mode='rb'):
  """Open a file from a specific location.

  Args:
    location: The directory containing the file.
    filename: The name of the file.
    mode: File mode for open().

  Returns:
    A file object.
  """
  return open(location + filename, mode)

class GruyereRequestHandler(BaseHTTPRequestHandler):
  """Handle a http request."""

  # An empty cookie
  NULL_COOKIE = {COOKIE_UID: None, COOKIE_ADMIN: False, COOKIE_AUTHOR: False}

  # Urls that can only be accessed by administrators.
  _PROTECTED_URLS = [
      '/quit',
      '/reset'
  ]

  def _GetDatabase(self):
    """Gets the database."""
    global stored_data
    if not stored_data:
       stored_data = data.DefaultData()
    return stored_data

  def _ResetDatabase(self):
    """Reset the database."""
    # global stored_data
    stored_data = data.DefaultData()

  def _DoLogin(self, cookie, specials, params):
    """Handles the /login url: validates the user and creates a cookie.

    Args:
      cookie: The cookie for this request.
      specials: Other special values for this request.
      params: Cgi parameters.
    """
    database = self._GetDatabase()
    message = ''
    if 'uid' in params and 'pw' in params:
      uid = self._GetParameter(params, 'uid')
      if uid in database:
        if database[uid]['pw'] == self._GetParameter(params, 'pw'):
          (cookie, new_cookie_text) = (
              self._CreateCookie('GRUYERE', uid))
          self._DoHome(cookie, specials, params, new_cookie_text)
          return
      message = 'Invalid user name or password.'
    # not logged in
    specials['_message'] = message
    self._SendTemplateResponse('/login.gtl', specials, params)

  def _DoLogout(self, cookie, specials, params):
    """Handles the /logout url: clears the cookie.

    Args:
      cookie: The cookie for this request.
      specials: Other special values for this request.
      params: Cgi parameters.
    """
    (cookie, new_cookie_text) = (
        self._CreateCookie('GRUYERE', None))
    self._DoHome(cookie, specials, params, new_cookie_text)

  def _Do(self, cookie, specials, params):
    """Handles the home page (http://localhost/).

    Args:
      cookie: The cookie for this request.
      specials: Other special values for this request.
      params: Cgi parameters.
    """
    self._DoHome(cookie, specials, params)

  def _DoHome(self, cookie, specials, params, new_cookie_text=None):
    """Renders the home page.

    Args:
      cookie: The cookie for this request.
      specials: Other special values for this request.
      params: Cgi parameters.
      new_cookie_text: New cookie.
    """
    database = self._GetDatabase()
    specials[SPECIAL_COOKIE] = cookie
    if cookie and cookie.get(COOKIE_UID):
      specials[SPECIAL_PROFILE] = database.get(cookie[COOKIE_UID])
    else:
      specials.pop(SPECIAL_PROFILE, None)
    self._SendTemplateResponse(
        '/home.gtl', specials, params, new_cookie_text)

  def _DoBadUrl(self, path, cookie, specials, params):
    """Handles invalid urls: displays an appropriate error message.

    Args:
      path: The invalid url.
      cookie: The cookie for this request.
      specials: Other special values for this request.
      params: Cgi parameters.
    """
    self._SendError('Invalid request: %s' % (path,), cookie, specials, params)

  def _DoQuitserver(self, cookie, specials, params):
    """Handles the /quitserver url for administrators to quit the server.

    Args:
      cookie: The cookie for this request. (unused)
      specials: Other special values for this request. (unused)
      params: Cgi parameters. (unused)
    """
    global quit_server
    quit_server = True
    self._SendTextResponse('Server quit.', None)

  def _AddParameter(self, name, params, data, default=None):
    """Transfers a value (with a default) from the parameters to the data."""
    if params.get(name):
      data[name] = params[name][0]
    elif default is not None:
      data[name] = default

  def _GetParameter(self, params, name, default=None):
    """Gets a parameter value with a default."""
    if params.get(name):
      return params[name][0]
    return default

  def _GetSnippets(self, cookie, specials, create=False):
    """Returns all of the user's snippets."""
    database = self._GetDatabase()
    try:
      profile = database[cookie[COOKIE_UID]]
      if create and 'snippets' not in profile:
        profile['snippets'] = []
      snippets = profile['snippets']
    except (KeyError, TypeError):
      _Log('Error getting snippets')
      return None
    return snippets

  def _DoNewsnippet2(self, cookie, specials, params):
    """Handles the /newsnippet2 url: actually add the snippet.

    Args:
      cookie: The cookie for this request.
      specials: Other special values for this request.
      params: Cgi parameters.
    """
    snippet = self._GetParameter(params, 'snippet')
    if not snippet:
      self._SendError('No snippet!', cookie, specials, params)
    else:
      snippets = self._GetSnippets(cookie, specials, True)
      if snippets is not None:
        snippets.insert(0, snippet)
    self._SendRedirect('/snippets.gtl', specials[SPECIAL_UNIQUE_ID])

  def _DoDeletesnippet(self, cookie, specials, params):
    """Handles the /deletesnippet url: delete the indexed snippet.

    Args:
      cookie: The cookie for this request.
      specials: Other special values for this request.
      params: Cgi parameters.
    """
    index = self._GetParameter(params, 'index')
    snippets = self._GetSnippets(cookie, specials)
    try:
      del snippets[int(index)]
    except (IndexError, TypeError, ValueError):
      self._SendError(
          'Invalid index (%s)' % (index,),
          cookie, specials, params)
      return
    self._SendRedirect('/snippets.gtl', specials[SPECIAL_UNIQUE_ID])

  def _DoSaveprofile(self, cookie, specials, params):
    """Saves the user's profile.

    Args:
      cookie: The cookie for this request.
      specials: Other special values for this request.
      params: Cgi parameters.

    If the 'action' cgi parameter is 'new', then this is creating a new user
    and it's an error if the user already exists. If action is 'update', then
    this is editing an existing user's profile and it's an error if the user
    does not exist.
    """

    # build new profile
    profile_data = {}
    uid = self._GetParameter(params, 'uid', cookie[COOKIE_UID])
    newpw = self._GetParameter(params, 'pw')
    self._AddParameter('name', params, profile_data, uid)
    self._AddParameter('pw', params, profile_data)
    self._AddParameter('is_author', params, profile_data)
    self._AddParameter('is_admin', params, profile_data)
    self._AddParameter('private_snippet', params, profile_data)
    self._AddParameter('icon', params, profile_data)
    self._AddParameter('web_site', params, profile_data)
    self._AddParameter('color', params, profile_data)

    # Each case below has to set either error or redirect
    database = self._GetDatabase()
    message = None
    new_cookie_text = None
    action = self._GetParameter(params, 'action')
    if action == 'new':
      if uid in database:
        message = 'User already exists.'
      else:
        profile_data['pw'] = newpw
        database[uid] = profile_data
        (cookie, new_cookie_text) = self._CreateCookie('GRUYERE', uid)
        message = 'Account created.'  # error message can also indicates success
    elif action == 'update':
      if uid not in database:
        message = 'User does not exist.'
      elif (newpw and database[uid]['pw'] != self._GetParameter(params, 'oldpw')
            and not cookie.get(COOKIE_ADMIN)):
        # must be admin or supply old pw to change password
        message = 'Incorrect password.'
      else:
        if newpw:
          profile_data['pw'] = newpw
        database[uid].update(profile_data)
        redirect = '/'
    else:
      message = 'Invalid request'
    _Log('SetProfile(%s, %s): %s' %(str(uid), str(action), str(message)))
    if message:
      self._SendError(message, cookie, specials, params, new_cookie_text)
    else:
      self._SendRedirect(redirect, specials[SPECIAL_UNIQUE_ID])

  def _SendHtmlResponse(self, html, new_cookie_text=None):
    """Sends the provided html response with appropriate headers.

    Args:
      s: The response.
      new_cookie_text: New cookie to set.
    """
    self.send_response(200)
    self.send_header('Content-type', 'text/html')
    self.send_header('Pragma', 'no-cache')
    if new_cookie_text:
      self.send_header('Set-Cookie', new_cookie_text)
    self.send_header('X-XSS-Protection', '0')
    self.end_headers()
    self.wfile.write(html)

  def _SendTextResponse(self, text, new_cookie_text=None):
    """Sends a verbatim text response."""

    self._SendHtmlResponse('<pre>' + cgi.escape(text) + '</pre>',
        new_cookie_text)

  def _SendTemplateResponse(self, filename, specials, params,
                            new_cookie_text=None):
    """Sends a response using a gtl template.

    Args:
      filename: The template file.
      specials: Other special values for this request.
      params: Cgi parameters.
      new_cookie_text: New cookie to set.
    """
    f = None
    try:
      f = _Open(RESOURCE_PATH, filename)
      template = f.read()
    finally:
      if f: f.close()
    self._SendHtmlResponse(
        gtl.ExpandTemplate(template, specials, params),
        new_cookie_text)

  def _SendFileResponse(self, filename, cookie, specials, params):
    """Sends the contents of a file.

    Args:
      filename: The file to send.
      cookie: The cookie for this request.
      specials: Other special values for this request.
      params: Cgi parameters.
    """
    content_type = None
    if filename.endswith('.gtl'):
      self._SendTemplateResponse(filename, specials, params)
      return

    name_only = filename[filename.rfind('/'):]
    extension = name_only[name_only.rfind('.'):]
    if '.' not in extension:
      content_type = 'text/plain'
    elif extension in RESOURCE_CONTENT_TYPES:
      content_type = RESOURCE_CONTENT_TYPES[extension]
    else:
      self._SendError(
          'Unrecognized file type (%s).' % (filename,),
          cookie, specials, params)
      return
    f = None
    try:
      f = _Open(RESOURCE_PATH, filename, 'rb')
      self.send_response(200)
      self.send_header('Content-type', content_type)
      # Always cache static resources
      self.send_header('Cache-control', 'public, max-age=7200')
      self.send_header('X-XSS-Protection', '0')
      self.end_headers()
      self.wfile.write(f.read())
    finally:
      if f: f.close()

  def _SendError(self, message, cookie, specials, params, new_cookie_text=None):
    """Sends an error message (using the error.gtl template).

    Args:
      message: The error to display.
      cookie: The cookie for this request. (unused)
      specials: Other special values for this request.
      params: Cgi parameters.
      new_cookie_text: New cookie to set.
    """
    specials['_message'] = message
    self._SendTemplateResponse(
        '/error.gtl', specials, params, new_cookie_text)

  def _CreateCookie(self, cookie_name, uid):
    """Creates a cookie for this user.

    Args:
      cookie_name: Cookie to create.
      uid: The user.

    Returns:
      (cookie, new_cookie_text).

    The cookie contains all the information we need to know about
    the user for normal operations, including whether or not the user
    should have access to the authoring pages or the admin pages.
    The cookie is signed with a hash function.
    """
    if uid is None:
      return (self.NULL_COOKIE, cookie_name + '=; path=/')
    database = self._GetDatabase()
    profile = database[uid]
    if profile.get('is_author', False):
      is_author = 'author'
    else:
      is_author = ''
    if profile.get('is_admin', False):
      is_admin = 'admin'
    else:
      is_admin = ''

    c = {COOKIE_UID: uid, COOKIE_ADMIN: is_admin, COOKIE_AUTHOR: is_author}
    c_data = '%s|%s|%s' % (uid, is_admin, is_author)

    # global cookie_secret; only use positive hash values
    h_data = str(hash(cookie_secret + c_data) & 0x7FFFFFF)
    c_text = '%s=%s|%s; path=/' % (cookie_name, h_data, c_data)
    return (c, c_text)

  def _GetCookie(self, cookie_name):
    """Reads, verifies and parses the cookie.

    Args:
      cookie_name: The cookie to get.

    Returns:
      a dict containing user, is_admin, and is_author if the cookie
      is present and valid. Otherwise, None.
    """
    cookies = self.headers.get('Cookie')
    if isinstance(cookies, str):
      for c in cookies.split(';'):
        matched_cookie = self._MatchCookie(cookie_name, c)
        if matched_cookie:
          return self._ParseCookie(matched_cookie)
    return self.NULL_COOKIE

  def _MatchCookie(self, cookie_name, cookie):
    """Matches the cookie.

    Args:
      cookie_name: The name of the cookie.
      cookie: The full cookie (name=value).

    Returns:
      The cookie if it matches or None if it doesn't match.
    """
    try:
      (cn, cd) = cookie.strip().split('=', 1)
      if cn != cookie_name:
        return None
    except (IndexError, ValueError):
      return None
    return cd

  def _ParseCookie(self, cookie):
    """Parses the cookie and returns NULL_COOKIE if it's invalid.

    Args:
      cookie: The text of the cookie.

    Returns:
      A map containing the values in the cookie.
    """
    try:
      (hashed, data) = cookie.split('|', 1)
      # global cookie_secret
      if hashed != str(hash(cookie_secret + data) & 0x7FFFFFF):
        return self.NULL_COOKIE
      values = data.split('|')
      return {
          COOKIE_UID: values[0],
          COOKIE_ADMIN: values[1] == 'admin',
          COOKIE_AUTHOR: values[2] == 'author',
      }
    except (IndexError, ValueError):
      return self.NULL_COOKIE

  def _DoReset(self, cookie, specials, params):  # debug only; resets this db
    """Handles the /reset url for administrators to reset the database.

    Args:
      cookie: The cookie for this request. (unused)
      specials: Other special values for this request. (unused)
      params: Cgi parameters. (unused)
    """
    self._ResetDatabase()
    self._SendTextResponse('Server reset to default values...', None)

  def _DoUpload2(self, cookie, specials, params):
    """Handles the /upload2 url: finish the upload and save the file.

    Args:
      cookie: The cookie for this request.
      specials: Other special values for this request.
      params: Cgi parameters. (unused)
    """
    (filename, file_data) = self._ExtractFileFromRequest()
    directory = self._MakeUserDirectory(cookie[COOKIE_UID])

    message = None
    url = None
    try:
      f = _Open(directory, filename, 'wb')
      f.write(file_data)
      f.close()
      (host, port) = http_server.server_address
      url = 'http://%s:%d/%s/%s/%s' % (
        host, port, specials[SPECIAL_UNIQUE_ID], cookie[COOKIE_UID], filename)
    except IOError, ex:
      message = 'Couldn\'t write file %s: %s' % (filename, ex.message)
      _Log(message)

    specials['_message'] = message
    self._SendTemplateResponse(
        '/upload2.gtl', specials,
        {'url': url})

  def _ExtractFileFromRequest(self):
    """Extracts the file from an upload request.

    Returns:
      (filename, file_data)
    """
    form = cgi.FieldStorage(
        fp=self.rfile,
        headers=self.headers,
        environ={'REQUEST_METHOD': 'POST',
                 'CONTENT_TYPE': self.headers.getheader('content-type')})

    upload_file = form['upload_file']
    file_data = upload_file.file.read()
    return (upload_file.filename, file_data)

  def _MakeUserDirectory(self, uid):
    """Creates a separate directory for each user to avoid upload conflicts.

    Args:
      uid: The user to create a directory for.

    Returns:
      The new directory path (/uid/).
    """

    directory = RESOURCE_PATH + os.sep + str(uid) + os.sep
    try:
      print "mkdir: ",directory
      os.mkdir(directory)
      # throws an exception if directory already exists,
      # however exception type varies by platform
    except Exception:
      pass  # just ignore it if it already exists
    return directory

  def _SendRedirect(self, url, unique_id):
    """Sends a 302 redirect.

    Automatically adds the unique_id.

    Args:
      url: The location to redirect to which must start with '/'.
      unique_id: The unique id to include in the url.
    """
    if not url:
      url = '/'
    url = '/' + unique_id + url
    self.send_response(302)
    self.send_header('Location', url)
    self.send_header('Pragma', 'no-cache')
    self.send_header('Content-type', 'text/html')
    self.send_header('X-XSS-Protection', '0')
    self.end_headers()
    self.wfile.write(
        '''<!DOCTYPE HTML PUBLIC '-//W3C//DTD HTML//EN'>
        <html><body>
        <title>302 Redirect</title>
        Redirected <a href="%s">here</a>
        </body></html>'''
        % (url,))

  def _GetHandlerFunction(self, path):
    try:
      return getattr(GruyereRequestHandler, '_Do' + path[1:].capitalize())
    except AttributeError:
      return None

  def do_POST(self):  # part of BaseHTTPRequestHandler interface
    self.DoGetOrPost()

  def do_GET(self):  # part of BaseHTTPRequestHandler interface
    self.DoGetOrPost()

  def DoGetOrPost(self):
    """Validate an http get or post request and call HandleRequest."""

    url = urlparse(self.path)
    path = url[2]
    query = url[4]

    # Normally, Gruyere only accepts connections to/from localhost. If you
    # would like to allow access from other ip addresses, add the addresses
    # of the other machines to allowed_ips and change insecure_mode to True
    # above. This makes the application more vulnerable to a real attack so
    # you should only add ips of machines you completely control and make
    # sure that you are not using them to access any other web pages while
    # you are using Gruyere.

    allowed_ips = ['127.0.0.1']

    # WARNING! DO NOT CHANGE THE FOLLOWING SECTION OF CODE!

    # This application is very exploitable. See main for details. What we're
    # doing here is (2) and (3) on the previous list:
    #   (2) If a request is received from any IP other than localhost, quit.
    # An external attacker could still mount an attack on this IP by putting
    # an attack on an external web page, e.g., a web page that redirects to
    # a vulnerable url on 127.0.0.1 (which is why we use a random number).
    #   (3) Inject a random identifier as the first part of the path and
    # quit if a request is received without this identifier (except for an
    # empty path which redirects and /favicon.ico).

    request_ip = self.client_address[0]                      # DO NOT CHANGE
    if request_ip not in allowed_ips:                        # DO NOT CHANGE
      print >>sys.stderr, (                                  # DO NOT CHANGE
          'DANGER! Request from bad ip: ' + request_ip)      # DO NOT CHANGE
      _Exit('bad_ip')                                        # DO NOT CHANGE

    if (server_unique_id not in path                         # DO NOT CHANGE
        and path != '/favicon.ico'):                         # DO NOT CHANGE
      if path == '' or path == '/':                          # DO NOT CHANGE
        self._SendRedirect('/', server_unique_id)            # DO NOT CHANGE
        return                                               # DO NOT CHANGE
      else:                                                  # DO NOT CHANGE
        print >>sys.stderr, (                                # DO NOT CHANGE
            'DANGER! Request without unique id: ' + path)    # DO NOT CHANGE
        # Changed for gauntlt, we need to be able request random URLs
        # DO NOT USE THIS FOR NON-GAUNTLT TESTING
        #_Exit('bad_id')                                     # DO NOT CHANGE

    path = path.replace('/' + server_unique_id, '', 1)       # DO NOT CHANGE

    # END WARNING!

    self.HandleRequest(path, query, server_unique_id)

  def HandleRequest(self, path, query, unique_id):
    """Handles an http request.

    Args:
      path: The path part of the url, with leading slash.
      query: The query part of the url, without leading question mark.
      unique_id: The unique id from the url.
    """

    path = urllib.unquote(path)

    if path == '':
      self._SendRedirect('/', server_unique_id)
      return
    params = cgi.parse_qs(query)  # url.query
    specials = {}
    cookie = self._GetCookie('GRUYERE')
    database = self._GetDatabase()
    specials[SPECIAL_COOKIE] = cookie
    specials[SPECIAL_DB] = database
    specials[SPECIAL_PROFILE] = database.get(cookie.get(COOKIE_UID))
    specials[SPECIAL_PARAMS] = params
    specials[SPECIAL_UNIQUE_ID] = unique_id

    if path in self._PROTECTED_URLS and not cookie[COOKIE_ADMIN]:
      self._SendError('Invalid request', cookie, specials, params)
      return

    try:
      handler = self._GetHandlerFunction(path)
      if callable(handler):
        (handler)(self, cookie, specials, params)
      else:
        try:
          self._SendFileResponse(path, cookie, specials, params)
        except IOError:
          self._DoBadUrl(path, cookie, specials, params)
    except KeyboardInterrupt:
      _Exit('KeyboardInterrupt')


def _Log(message):
  print >>sys.stderr, message


if __name__ == '__main__':
  main()
