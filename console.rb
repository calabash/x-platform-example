#!/usr/bin/env ruby
target = ARGV[0]

if target == 'android'
  exec("bundle exec calabash-android console prebuilt/Android-debug.apk")
elsif target == 'ios'
  exec("APP_BUNDLE_PATH=prebuilt/WordPress-cal.app bundle exec calabash-ios console")
else
    puts "Invalid target #{target}"
end
