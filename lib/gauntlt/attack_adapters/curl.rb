When /^"curl" is installed$/ do
  ensure_cli_installed("curl")
end

When /^I launch (?:a|an) "curl" attack with:$/ do |command|
  run_with_profile command
  @raw_curl_response = all_output # aruba defines all_output
end

Then /^the following cookies should be received:$/ do |table|
  set_cookies( cookies_for_last_curl_request )

  table.hashes.each do |h|
    cookie_by_name = cookies.select{|e| e[:name] == h['name']}
    expect(cookie_by_name.any?).to be_truthy

    c = cookie_by_name.first

    h.each do |k,v|
      unless v.empty?
        expect(c[k.to_sym]).to_not be_nil
        expect(c[k.to_sym]).to eq(v)
      end
    end
  end
end
