Given(/^I am in the register page$/) do
	@current_page = page(LoginPage)
	@current_page.go_to_register_page
end

When(/^I enter (.*) (.*) (.*) and (.*) for registration$/) do |name, lastname, email, pass|
	@current_page = page(RegisterPage).await(timeout: 300)
	@current_page.fill_registration_form(name, lastname, email, pass)
end

Then(/^I should see the (.*)$/) do |result|
	@current_page.check_result(result)
end

Then(/^I ensure that the message is correct for each line$/) do |table|
	@current_page.fill_form table
end