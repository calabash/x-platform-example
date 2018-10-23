def turn_off_bluetooth
	# not yet implemented
end

def give_location_permission
	# after launching the application there might be pop-up for permission location access
	if device_agent.springboard_alert_visible?
		puts "- Needs to give permission, let's give a permission"

		begin
			device_agent.dismiss_springboard_alert("Always Allow")
		rescue
			device_agent.dismiss_springboard_alert("Allow")
		end
	end
end

def allow_notification
	# after launching the application there might be pop-up for permission
	if device_agent.springboard_alert_visible?
		puts "- Needs to give permission, let's give a permission"

		begin
			device_agent.dismiss_springboard_alert("Allow")
		rescue
			device_agent.dismiss_springboard_alert("Always Allow")
		end
	end
end

def allow_location
	touch_if_element_exists "BWButton marked:'Allow'"
end

def touch_beam_button
	wait_until_element_ready "* id:'Beam'"
	touch "* id:'Beam'"

	touch_if_element_exists "* id:'Beam'"
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
	wait_until_element_ready "UIButtonLabel text:'9'"

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
	sleep(0.5)
end

