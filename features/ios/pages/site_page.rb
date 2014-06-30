require 'calabash-cucumber/ibase'

class SitePage < Calabash::IBase

  def trait
    "* marked:'Me'"
  end

  def to_posts
    wait_for_none_animating
    touch(trait)
    wait_for_none_animating
    if element_exists("* marked:'Calabash Blog'")
      touch("* marked:'Calabash Blog'")
      wait_for_none_animating
    end
    touch("* marked:'Posts'")
    wait_for_none_animating
  end
end