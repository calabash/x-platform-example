#!/usr/bin/env ruby
target = ARGV.shift

ENV["platform"] = target
ENV["LOCALRUN"] = "true"

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
  exec("export APP=prebuilt/omgshop.apk && bundle exec calabash-android run $APP -p android #{ARGV.join(' ')}")
elsif target == 'ios'
  exec("export BUNDLE_ID=com.omisego.omg-shop && export DEVICE_ENDPOINT=http://10.0.1.69:37265 && export APP_BUNDLE_PATH=prebuilt/OMGShop-cal.ipa && bundle exec cucumber -p ios #{ARGV.join(' ')}")
elsif target == 'ios-simulator'
  exec("unset APP_BUNDLE_PATH && export BUNDLE_ID=com.omisego.omg-shop && export DEVICE_ENDPOINT=http://localhost:37265  && export APP_BUNDLE_PATH=prebuilt/OMGShop-cal.app && DEBUG=0 bundle exec cucumber -p ios #{ARGV.join(' ')}")
else
  puts "- Invalid target: #{target} \n - Available targets are: \n  * android\n  * ios\n  * ios-simulator"
end
