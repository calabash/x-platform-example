require 'calabash-android/abase'

class LoginPage < Calabash::ABase

  def trait
    "android.widget.TextView text:'Sign in'"
  end

  def await(wait_opts={})
    login_page = super(wait_opts)
    touch(user_field)
    login_page
  end

  def self_hosted_site
    begin
      wait_for_elements_exist ["android.widget.TextView text:'Add self-hosted site'"]
      touch("android.widget.TextView text:'Add self-hosted site'")
    rescue
      performAction('go_back') #Workaround for tablets not releasing keyboard
      touch("android.widget.TextView text:'Add self-hosted site'")
    end
  end

  def login(user,pass,site)
    enter_text(user_field, user)
    enter_text(pass_field, pass)
    enter_text(site_field, site)


    do_sign_in


    begin
      wait_for_login_done
    rescue => e
      performAction('go_back') #Workaround for tablets not releasing keyboard
      do_sign_in
      wait_for_login_done
    end

  end

  def do_sign_in
    begin
      touch(sign_in)
    rescue RuntimeError => e
      touch("android.widget.Button index:2")
    end
  end

  def sign_in
    "android.widget.TextView text:'Sign in'"
  end

  def user_field
    field('nux_username')
  end

  def pass_field
    field('nux_password')
  end

  def site_field
    field('nux_url')
  end

  def field(field_id)
    "android.widget.TextView id:'#{field_id}'"
  end

  def wait_for_login_done
    result = nil
    wait_for(timeout: 120) do
      if element_exists("android.widget.TextView {text BEGINSWITH 'The username or'}")
        result = :invalid
      elsif element_exists("* marked:'Posts'")
        result = :valid
      end
    end

    case result
      when :invalid
        self
      else
        page(SitePage)
    end
  end

end
