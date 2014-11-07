#!/usr/bin/env ruby
target = ARGV[0]

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
  exec("bundle exec calabash-android run prebuilt/Android-debug.apk -p android")
elsif target == 'ios'
  exec("bundle exec cucumber -p ios")
else
    puts "Invalid target #{target}"
end
