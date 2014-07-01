require 'calabash-android/abase'

class SitePage < Calabash::ABase

  def trait
    "* marked:'Posts'"
  end

  def to_posts
    touch(query("* marked:'Posts'").last)
  end



end

