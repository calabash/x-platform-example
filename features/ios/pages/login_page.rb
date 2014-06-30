require 'calabash-cucumber/ibase'

class LoginPage < Calabash::IBase

  def trait
    "button marked:'Sign In'"
  end


  def self_hosted_site
    touch("* marked:'Add Self-Hosted Site'")
    wait_for_none_animating
  end

  def login(user,pass,site)
    enter_text(user_field, user)
    enter_text(pass_field, pass)
    enter_text(site_field, site)

    touch(add_site)

    wait_for_login_done
  end

  def enter_text(query_string, text)
    # do it
    touch(query_string)
    wait_for_keyboard
    keyboard_enter_text text

  end

  def sign_in
    trait()
  end

  def add_site
    "button marked:'Add Site'"
  end

  def user_field
    "* marked:'Username / Email'"
  end

  def pass_field
    "* marked:'Password'"
  end

  def site_field
    "* marked:'Site Address (URL)'"
  end

  def wait_for_login_done
    result = nil
    site_page = page(SitePage)



    wait_for(timeout: 60) do
      if element_exists("label text:'Need Help?'")
        result = :invalid
      elsif element_exists(site_page.trait)
        result = :valid
      end
    end


    case result
      when :invalid
        self
      else
        site_page.await(timeout:10)
    end
  end

end