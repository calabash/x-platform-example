require "cucumber"

module Calabash
  module Xplatform
    def turn_off_bluetooth
      # not yet implemented
    end

    def allow_location
      touch_if_element_exists "BWButton marked:'Allow'"
    end

    def touch_button button
      touch "* {text CONTAINS[c] '#{button}'}"
    end

    def touch_button_text button
      touch "* {text CONTAINS[c] '#{button}'}"
    end

    def touch_close_button
      touch "* marked:'close'"
    end

    def enable_bluetooth
      # need to search about this
    end

    def enter_pin(pin)
      wait_until_element_visible "UIButtonLabel text:'9'"

      number = ""

      pin.split("").each do |num|
        touch "UIButtonLabel text:'#{num}'"

        number += num.to_s

        # element may disappear for the last digit
        begin
          if(query("UIFieldEditor index:0")[0]["value"] != number)
            touch "UIButtonLabel text:'#{num}'"                  
          end
        rescue
          puts "- UIFieldEditor element is disappeared"
        end
      end
    end

    def double_tap_for_authentication
      two_finger_tap "* id:'reader'"
      wait_for_none_animating

      touch "* marked:'OK'"
    end

    def go_back
      # predefined step "I go back" doesn't work for ios 12
      touch "view:'_UIButtonBarButton' first"
      wait_for_none_animating
    end
    
  end
end

World(Calabash::Xplatform)

