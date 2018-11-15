#!/usr/bin/env ruby
target = ARGV[0]

ENV["platform"] = target

unless system("bundle version")
  puts "Can't find bundler. Check your ruby environment."
  puts "If your using ~/.calabash then run:"
  puts <<EOF

export GEM_HOME=~/.calabash
export GEM_PATH=~/.calabash
export PATH="$PATH:$HOME/.calabash/bin"
EOF
  exit(false)
end

if target == 'android'
  exec("bundle exec calabash-android console prebuilt/omgshop.apk")
elsif target == 'ios'
  exec("export BUNDLE_ID=com.omisego.omg-shop && export DEVICE_TARGET=47967909d0b90df7d3444d2bbb8b44233475eba5 && export DEVICE_ENDPOINT=http://10.0.1.69:37265 && export APP_BUNDLE_PATH=prebuilt/OMGShop-cal.ipa && bundle exec calabash-ios console")
elsif target == 'ios-simulator'
  exec("export DEVICE_TARGET='5308AACE-77E6-4F3E-89FC-A4B8E2BBECD6' && export DEVICE_ENDPOINT='http://localhost:37265' && export APP_BUNDLE_PATH=prebuilt/OMGShop-cal.app && bundle exec calabash-ios console")
else
  puts "Invalid target #{target}"
end
