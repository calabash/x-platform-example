require 'calabash-android/abase'

class InfoPage < Calabash::ABase

  def trait
    "* id:'nux_help_description'"
  end

  def assert_info_present
    ids = ['help_button', 'applog_button']
    ids.each do |txt|
      check_element_exists "* id:'#{txt}'"
    end
  end

end