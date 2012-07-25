Given /^an attack "(.*?)" exists$/ do |attack_name|
  Gauntlt.should have_attack(attack_name)
end