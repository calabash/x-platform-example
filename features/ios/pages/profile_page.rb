require 'calabash-cucumber/ibase'

class ProfilePage < Calabash::IBase

  def trait
    "* text:'My profile'"
  end

  def logout
  	touch "* text:'Log out'"
  	wait_until_text_visible "Log in"
  end

end
