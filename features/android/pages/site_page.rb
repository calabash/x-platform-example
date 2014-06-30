require 'calabash-android/abase'

class SitePage < Calabash::ABase

  def trait
    "* marked:'Posts'"
  end

  def to_posts
    sleep(10)
    touch("* marked:'Posts'")
    sleep(10)
  end



end

