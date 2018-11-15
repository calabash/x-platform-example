require "calabash-android"


module Calabash
  module Xplatform
    def turn_off_bluetooth
      system "adb shell service call bluetooth_manager 9 2>/dev/null"
    end

    def turn_on_bluetooth
      system "adb shell service call bluetooth_manager 6 2>/dev/null"
    end

    def give_location_permission
      system "adb shell pm grant co.omisego.omgshop.test android.permission.ACCESS_COARSE_LOCATION"
    end

    def touch_button button
      touch "AppCompatButton {text CONTAINS[c] '#{button}'}"
    end

    def touch_button_text button
      touch "* {text CONTAINS[c] '#{button}'}"
    end

    def touch_close_button
      touch "* id:'close'"
    end

    def enable_bluetooth
      wait_until_element_visible "AppCompatButton id:'NoResourceEntry-0'"
      touch "AppCompatButton id:'NoResourceEntry-0'"
    end

    def double_tap_for_authentication
      # no need for android for now!
      # two_finger_tap "* id:'reader'"
    end

    def go_back
      macro "I go back"
    end

  end
end

World(Calabash::Xplatform)
