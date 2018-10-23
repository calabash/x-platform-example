require 'calabash-cucumber/ibase'

class RegisterPage < Calabash::IBase

  def trait
    "* text:'Register'"
  end

  def fill_registration_form(name, lastname, email, pass)
		if email == "NewEmail"
			email = "test#{Time.now.to_i}@gmail.com"
			puts email
		end

		enter_text "* text:'First name'", "#{name}"

		scroll "scrollView", :down
		enter_text "* text:'Last name'", "#{lastname}"

		enter_text "* text:'Email'", "#{email}"

		scroll "scrollView", :down
		enter_text "* text:'Password'", "#{pass}"

		scroll "scrollView", :down
		touch "UIButtonLabel text:'Register'"

		wait_for_none_animating
  end

  def check_result(result)
		case result
		when "Fail"
			check_element_exists "* id:'First name'"
		when "Success"
			wait_until_text_visible "Products"
			check_element_exists "* text:'Products'"
		end  	
  end


end
