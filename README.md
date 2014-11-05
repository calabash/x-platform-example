# Running the samples

Make sure you have Ruby 1.9 or above installed (Ruby 2.0+ recommended).

Install bundler unless you already have it installed:

    gem install bundler

(or sudo gem install bundler)


Install gems in the `Gemfile`:

    bundle install

# iOS

To run the iOS tests, make sure Xcode 6.1 is installed with command line tools.

Run

    bundle exec cucumber -p ios

or

    ./run.rb ios

Calabash console

    ./console.rb ios
    
Run `start_test_server_in_background`.

# Android

To run the Android tests, ensure a recent Android SDK is installed, and that

* environment variable `ANDROID_HOME` is set to point to the sdk folder, for example `/Users/krukow/android/adt/sdk`

Run

    bundle exec calabash-android run prebuilt/Android-debug.apk -p android

or

    ./run.rb android

Calabash console

    ./console.rb android

Run `start_test_server_in_background`.

