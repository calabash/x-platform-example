
Given(/^I prepare the state of the app as logout user$/) do
  set_current_user

  case app_state
  when :logout
    # home page opens as logout by default
  when :login
    steps %{
      When I go to my profile
      When I log out
    }
  end
end

When(/^I go to my profile$/) do
  @current_page = page(ProductsPage).await(timeout: 30)
  @current_page.go_to_profile
end

When(/^I log out$/) do
  @current_page = page(ProfilePage).await(timeout: 30)
  @current_page.logout
end

When(/^I log in$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

When(/^I touch the log-in button$/) do
  @current_page.touch_login_button
end

Given(/^I am in the login page$/) do
  @current_page = page(LoginPage).await(timeout: 30)
end

When(/^I fill in "(.*?)" as "(.*?)"$/) do |input, text|
  @current_page.fill_in_input(input, text)
end

When(/^I touch the {string} button$/) do |text|
  touch_button_text text
end

Then(/^I should see "(.*?)" text$/) do |text|
  wait_until_text_visible text
  check_element_exists "* text:'#{text}'"
end