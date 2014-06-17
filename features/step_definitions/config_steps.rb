Given /^an attack "(.*?)" exists$/ do |attack_name|
  expect(Gauntlt.attacks).to include(attack_name)
end
