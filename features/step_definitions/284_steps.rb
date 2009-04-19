Given /^I am looking at the login page$/ do
  visit '/login'
end

Given /^the user "(.*)" exists with password "(.*)"$/ do |name, pass|
  User.new(:username => name, :password => pass, :password_confirmation => pass).save(false)
end
