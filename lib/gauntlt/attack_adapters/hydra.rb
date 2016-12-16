When /^"hydra" is installed$/ do
  ensure_cli_installed("hydra")
end

When /^I launch (?:a|an) "hydra" attack with:$/ do |command|
  add_to_profile('form_url_path', get_shell_variable("FORM_URL"))
  run_with_profile command
  @raw_hydra_output = all_output
end

