require 'calabash-android/abase'

class RegisterPage < Calabash::ABase

  def trait
    "* text:'Register'"
  end

  def fill_registration_form(name, lastname, email, pass)
    if email == "NewEmail"
      email = "test#{Time.now.to_i}@gmail.com"
    end

    enter_text "* id:'etFirstName'", name

    scroll "scrollView", :down
    enter_text "* id:'etLastName'", lastname

    enter_text "* id:'etEmail'", email

    scroll "scrollView", :down
    enter_text "* id:'etPassword'", pass

    scroll "scrollView", :down
    touch "* id:'btnRegister'"
    wait_for_none_animating
  end

  def check_result(result)
    wait_for_none_animating
    
    case result
    when "Fail"
      check_element_exists "* id:'etFirstName'"
    when "Success"
      wait_until_text_visible "Products"
      check_element_exists "* text:'Products'"
    end    
  end

end
