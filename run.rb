#!/usr/bin/env ruby
target = ARGV[0]

if target == 'android'
  exec("bundle exec calabash-android run prebuilt/Android-debug.apk -p android")
elsif target == 'ios'
  exec("bundle exec cucumber -p ios")
else
    puts "Invalid target #{target}"
end
