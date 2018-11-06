require 'calabash-android/abase'

class ProfilePage < Calabash::ABase

  def trait
    "* text:'My Profile'"
  end

  def logout
    wait_until_element_ready "* text:'LOG OUT'"
    touch "* text:'LOG OUT'"
    wait_until_text_visible "Log in"
  end

end
