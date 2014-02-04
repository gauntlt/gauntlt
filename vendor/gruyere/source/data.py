"""Gruyere - Default data for Gruyere, a web application with holes.

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

import copy

DEFAULT_DATA = {
    'administrator': {
        'name': 'Admin',
        'pw': 'secret',
        'is_author': False,
        'is_admin': True,
        'private_snippet': 'My password is secret. Get it?',
        'web_site': 'http://www.google.com/contact/security.html',
    },
    'cheddar': {
        'name': 'Cheddar Mac',
        'pw': 'orange',
        'is_author': True,
        'is_admin': False,
        'private_snippet': 'My SSN is <a href="http://www.google.com/' +
            'search?q=078-05-1120">078-05-1120</a>.',
        'web_site': 'http://images.google.com/images?q=cheddar+cheese',
        'color': 'blue',
        'snippets': [
          'Gruyere is the cheesiest application on the web.',
          'I wonder if there are any security holes in this....'
        ],
    },
    'sardo': {
        'name': 'Miss Sardo',
        'pw': 'odras',
        'is_author': True,
        'is_admin': False,
        'private_snippet': 'I hate my brother Romano.',
        'web_site': 'http://www.google.com/search?q="pecorino+sardo"',
        'color': 'red',
        'snippets': [],
    },
    'brie': {
        'name': 'Brie',
        'pw': 'briebrie',
        'is_author': True,
        'is_admin': False,
        'private_snippet': 'I use the same password for all my accounts.',
        'web_site': 'http://news.google.com/news/search?q=brie',
        'color': 'red; text-decoration:underline',
        'snippets': [
            'Brie is the queen of the cheeses<span style=color:red>!!!</span>'
        ],
    },
}


def DefaultData():
  """Provides default data for Gruyere."""
  return copy.deepcopy(DEFAULT_DATA)
