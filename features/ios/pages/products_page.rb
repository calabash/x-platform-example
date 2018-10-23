require 'calabash-cucumber/ibase'

class ProductsPage < Calabash::IBase

  def trait
    "* text:'Products'"
  end

  def go_to_profile
  	touch  "* index:38"
  	wait_until_text_visible "My profile"
  end

end
