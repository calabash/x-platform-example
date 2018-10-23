require 'net/http'
require 'uri'


def set_current_user(user = nil)
  if user.nil?
    begin
      case ENV["platform"]
      when "android"
        $current_user = Members.new.get("android")
      when "ios", "ios-simulator"
        $current_user = Members.new.get("ios")
      else
        puts "- current_user is not set. Platform should be one of:\n * android\n * ios\n * ios-simulator"
      end
    end
  else
    $current_user = Members.new.get(user)
  end
end

def embed_image(name, take_screenshot = true)
  screenshot_path = File.dirname(__FILE__) + '/media/' + name + '.png'

  if take_screenshot
    screenshot(screenshot_path)
  end
  embed(screenshot_path, "image/png", "SCREENSHOT")
end


def embed_screenshot scenario
  name = scenario.name.gsub(" ", "_").downcase
  screenshot_path = File.dirname(__FILE__) + '/media/' + ENV['platform'] + '/'
  screenshot_embed(options = {:prefix => screenshot_path, :name => name})
end

def wait_until_loader_disappear
  while query("* id:'wait_spinner'").size != 0
    sleep 0.5
  end
end

def wait_until_text_disappear(text)
  while check_if_text_exists(text)
    sleep 0.5
  end
end

def wait_until_text_visible(text)
  wait_until_element_ready "* {text CONTAINS[C] '#{text}'}"
end

def wait_until_element_ready(qr)
  10.times do
    if query(qr).size > 0
      break
    else
      sleep 1
      puts "- Element is not ready yet ...."
    end
  end
end

def wait_until_one_element_ready(*args)
  # this will wait until one of the element visible in the given query list
  # wait_until_one_element_ready("* text:'Stores'", "* text:'Places'")

  element = :not_exist

  10.times do
    args.each do |qr|
      if query(qr).size > 0
        element = :exist
        break
      end
    end

    if element == :exist
      break
    else
      sleep 1
      puts "- Element is not ready yet ...."
    end
  end
end


def check_obj_if_inside_the_container(container, obj)
  wait_for_text("Today", timeout: 10)

  # container: uniquery, contaioner object
  # obj: uniquery, will be check if inside the container
  #
  # x1                 y1
  #
  #    obj
  #
  # x2                 y2

  container = query(container)[0]
  obj = query(obj)[0]

  # boundaries = [x1, y1, x2, y2]
  x1, y1, x2, y2 = [container["rect"]["x"].to_i, container["rect"]["y"].to_i, container["rect"]["x"].to_i + container["rect"]["width"].to_i, container["rect"]["y"].to_i + container["rect"]["height"].to_i]
  obj_x, obj_y = obj["rect"]["center_x"].to_i, obj["rect"]["center_y"].to_i

  # puts x1, y1, x2, y2
  # puts obj_x, obj_y

  (obj_x.between?(x1, x2) and obj_y.between?(y1, y2)) ? true : false
end


def reinstall_ios_app
  %x{
		if [[ $(brew list|grep "ideviceinstaller"|wc -l) -eq 0 ]]; then
			echo -e " - Not found 'ideviceinstaller' for ios app installer. \n - installing ideviceinstaller"
			brew uninstall ideviceinstaller
			brew install --HEAD libimobiledevice
			brew link --overwrite libimobiledevice
			brew install --HEAD  ideviceinstaller
			brew link --overwrite ideviceinstaller
			# sudo chmod -R 777 /var/db/lockdown/
		else
			echo -e "\n - ideviceinstaller has been already installed."
		fi
	}

  system("ideviceinstaller -U '#{ENV["BUNDLE_ID"]}'")

  puts "- App removed, re-installing the app"

  system("ideviceinstaller -i '#{ENV["APP_BUNDLE_PATH"]}'")
end

def ios_app_installed?
  system("ideviceinstaller -l | grep #{ENV['BUNDLE_ID']}") == true
end

def check_if_element_exists query
  query(query).size != 0 ? true : false
end

def check_if_text_exists text
  query("* {text CONTAINS[c] '#{text}'}").size != 0 ? true : false
end

def touch_if_element_exists query
  if check_if_element_exists(query)
    touch query
  end
end

def check_api_last_transation
  # gets the last transaction from
  10.times do
    break if ($last_transaction["referenceNumber"] != get_last_transactions["referenceNumber"])
    puts "- API does not return new transactions, waiting 1 second . . . "
    sleep 2
  end

  $last_transaction = get_last_transactions
end

def generate_email(length = 6)
  chars = 'abcdefghjkmnpqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ0123456789'
  string = ''
  length.times {string << chars[rand(chars.size)]}
  random_email = "#{string}@test.qa"
  puts random_email
  return random_email
end

def generate_phone_number(length = 7)
  numbers = '0123456789'
  phone_number = ''
  length.times {phone_number << numbers[rand(numbers.size)]}
  mobile = "50#{phone_number}"
  puts mobile
  return mobile
end




def android?
  ENV["platform"] == 'android'
end

def ios?
  ENV["platform"] == 'ios' || ENV["platform"] == 'ios-simulator'
end

def local_run?
  ENV["LOCALRUN"] == "true"
end

def app_state
  status = :unknown

  10.times do
    if check_if_element_exists "* marked:'Products'"
      status = :login
      break
    elsif check_if_element_exists "* {text CONTAINS[C] 'Log in'}"
      status = :logout
      break
    else
      puts "- Clearing the notification popups . . ."
      touch_if_element_exists "* marked:'Allow'"
      wait_for_none_animating

      give_location_permission
      wait_for_none_animating

      sleep 0.5
    end
  end

  status
end