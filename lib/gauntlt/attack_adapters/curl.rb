When /^"curl" is installed$/ do
  ensure_cli_installed("curl")
end

When /^I launch (?:a|an) "curl" attack with:$/ do |command|
  run_with_profile command
  @raw_curl_response = all_output # aruba defines all_output
end

Then /^the following cookies should be received:$/ do |table|
  set_cookies( cookies_for_last_curl_request )

  names = table.hashes.map{|h| h['name'] }
  names.each do |name|
    expect(cookies.any?{|s| s =~ /^#{name}/}).to eq(true)
    # TODO: check other values in table
  end
end
