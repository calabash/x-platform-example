require 'calabash-cucumber/ibase'

class LoginPage < Calabash::IBase

  def trait
    "* text:'Log in'"
  end

  def fill_in_input(input, text)
    enter_text "* marked:'#{input}'", text
  end

  def touch_login_button
    touch_button_text "Log in"
    wait_until_text_disappear "Log in"
  end

  def go_to_register_page
    wait_for_none_animating
    rect = query("* {text CONTAINS[c] 'Register'}")[0]["rect"]
    x, y = ((rect["x"].to_i + rect["width"].to_i) * 0.90).to_i, rect["center_y"].to_i
    
    touch(nil, :offset => {:x => x, :y => y})
  end


end
