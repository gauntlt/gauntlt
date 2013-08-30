When /^"dirb" is installed$/ do
  ensure_cli_installed("dirb")
end

When /^the DIRB_WORDLISTS environment variable is set$/ do
  ensure_shell_variable_set("DIRB_WORDLISTS")
end

When /^I launch (?:a|an) "dirb" attack with:$/ do |command|
  add_to_profile('dirb_wordlists_path', get_shell_variable("DIRB_WORDLISTS"))
  run_with_profile command
  @raw_dirb_output = all_output
end
   
#
# When I run a "dirb" scan with this word list:
  # """
  # Admin
  # Administror
  # Secret-stats
  # dashboard
  # devtools
  # """

# When I run a "dirb" scan against an apache server
# When I run a "dirb" scan against a nginx server
# When I run a "dirb" scan with the small wordlist
# When I run a "dirb" scan with the large wordlist
# When I run a "dirb" scan with my custom wordlist: /path/to/wordlist.txt
