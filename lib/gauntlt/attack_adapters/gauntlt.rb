require 'nokogiri'
require 'net/http'

Given /^the following environment variables:$/ do |table|
  table.hashes.each do |hsh|
    add_to_profile_from_environment( hsh['name'], hsh['environment_variable_name'] )
  end
end

Given /^the following profile:$/ do |table|
  table.hashes.each do |hsh|
    add_to_profile( hsh['name'], hsh['value'] )
  end
end

When /^the file "(.*?)" should contain XML:$/ do |filename, css_selectors|
  css_selectors.hashes.each do |row|
    assert_xml_includes(filename, row['css'])
  end
end

When /^the file "(.*?)" should not contain XML:$/ do |filename, css_selectors|
  css_selectors.hashes.each do |row|
    assert_xml_does_not_include(filename, row['css'])
  end
end

And /^gauntlt successfully authenticates to the application/ do
  init = gauntlt_profile["initial_url"]
  uri = URI.parse(init)
  req = Net::HTTP::Get.new(uri.path)
  res = Net::HTTP.start(uri.host, uri.port) do |http|
      http.request(req)
  end

  cookie = res['Set-Cookie']
  token = ''
  if gauntlt_profile["get_rails_auth_token"] == "true"
    res.body.each_line do |line|
      next if line !~ /<input name="authenticity_token"/

      ix = line.index("<input name=\"authenticity_token\"")
      tmp = line[ix..line.length-1]
      tmp = tmp[0..tmp.index('/>')+1]

      token = Nokogiri::XML::Document.parse(tmp)
      token = token.root.attributes["value"]
      break
    end
  end

  params = (token == '' ? '' : 'authenticity_token=' + token)
  gauntlt_profile.keys.each do |key|
    next if key !~ /login-/

    k = key.sub('login-', '')
    params << (params == '' ? '' : '&') + k + '=' + gauntlt_profile[key]
  end

  headers = {
    'Cookie' => cookie
  }

  req = Net::HTTP::Post.new(gauntlt_profile['login_uri'], headers)
  req.body = params

  resp = Net::HTTP.new(uri.host, uri.port).start do |http| 
    http.request(req)
  end

  headers = {
    'Cookie' => resp['Set-Cookie']
  }

  if resp.code.to_i == 302

    raise "Authentication not successful" if resp['Location'] !~ /#{gauntlt_profile['login_expected_redirect']}/
    
    req = Net::HTTP::Get.new(resp['Location'], headers)
    resp = Net::HTTP.new(uri.host, uri.port).start do |http|
      http.request(req)
    end
  end

  add_to_profile('cookie_string', resp['Set-Cookie'])
end
