Given /^a verification test is defined for "(.*?)"$/ do |test_name|
  Gauntlt.should have_test(test_name)
end