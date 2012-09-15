Given /^an attack "(.*?)" exists$/ do |attack_name|
  Gauntlt.attacks.should include(attack_name)
end