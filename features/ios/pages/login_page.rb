require 'calabash-cucumber/ibase'

class LoginPage < Calabash::IBase

  def trait
    "button marked:'Sign In'"
  end


  def self_hosted_site

    tap_mark('Add Self-Hosted Site')

    wait_for_none_animating
  end

  def login(user,pass,site)
    # Note this example uses "enter_text"
    # You should use keyboard_enter_text by default
    # enter_text or set the option use_keyboard: true
    # wait: false means we know the field is ready to be tap'ed
    # e.g. no animations, so don't wait for it
    enter_text(user_field, user, use_keyboard: false)
    enter_text(pass_field, pass, use_keyboard: false, wait: false)
    enter_text(site_field, site, use_keyboard: false, wait: false)

    # If we used use_keyboard: true, this wouldn't be necessary
    # but use_keyboard: false is faster so we use it here
    touch("UITextField") # side-effect to have Add Site button enable
                      # after fast keyboard entry (= UIAutomation setValue)
    touch(add_site)

    wait_for_login_done
  end

  def more_information

    tap_mark 'Help'

    page(InfoPage).await()

  end


  def assert_can_create_account
    check_element_exists "* marked:'Create Account'"
  end

# Use 0.11.5 built-in enter-text
#  def enter_text(query_string, text)
#    touch(query_string)
#    wait_for_keyboard
#    keyboard_enter_text text
#  end

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
