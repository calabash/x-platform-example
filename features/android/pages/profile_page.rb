require 'calabash-android/abase'

class ProfilePage < Calabash::ABase

  def trait
    "* text:'My profile'"
  end

  def logout
  	touch "* text:'LOG OUT'"
  	wait_until_text_visible "Log in"
  end

end
