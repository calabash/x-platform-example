require 'calabash-android/abase'

class ProductsPage < Calabash::ABase

  def trait
    "* text:'Products'"
  end

  def go_to_profile
  	touch "* id:'profile'"
  	wait_until_text_visible "My Profile"
  end

end
