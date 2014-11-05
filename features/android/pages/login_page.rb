require 'calabash-android/abase'

class LoginPage < Calabash::ABase

  def trait
    "android.widget.TextView text:'Sign in'"
  end

  def self_hosted_site
    hide_soft_keyboard
    tap_when_element_exists(add_self_hosted_site_button)
  end

  def login(user,pass,site)
    enter_text(user_field, user)
    enter_text(pass_field, pass)
    enter_text(site_field, site)

    hide_soft_keyboard

    touch(sign_in)

    wait_for_login_done
  end

  def assert_can_create_account
    check_element_exists "* id:'nux_create_account_button'"
  end

  def more_information
    tap_mark "info_button"
    page(InfoPage).await
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

  def add_self_hosted_site_button
    "android.widget.TextView text:'Add self-hosted site'"
  end


  def wait_for_login_done
    result = nil
    wait_for(timeout: 120) do
      if element_exists("* {text BEGINSWITH 'The username or'}")
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
