require 'calabash-android/management/adb'
require 'calabash-android/operations'


Before do |scenario|
  scenario_tags = scenario.source_tag_names

  # for Amazon Device Farm no need to reinstall
  # it gives a fresh device every time for each .feature file
  # if you have more scenario in a .feature, you may need this
  if scenario_tags.include?('@reinstall') and ENV["LOCALRUN"] != "true"
    reinstall_apps
  end

  start_test_server_in_background
end


After do |scenario|
  if scenario.failed?
    embed_screenshot scenario
  end

  shutdown_test_server
end
