require "calabash-android"

=begin
These methods are implemented for Calabash-ios.
We are implementing their Android equivalents if possible so some of them may be empty.
=end


module Calabash
  module Android
    module WaitHelpers
      # waits for absence of loading spinner. Will raise an error after 45 seconds if spinner is still on the screen.
      def wait_for_none_animating
        begin
          Timeout::timeout(45) do
            sleep 1
            while element_exists("* marked:'Please wait'") || element_exists('CircleImageView') || element_exists('ProgressBar')
              sleep 0.7
            end
          end
        rescue Timeout::Error
          raise 'The page failed to load.'
        end
      end
    end

    module Operations
      def scroll_to_row_with_mark(text)
        query_text = "* {text CONTAINS[c] '#{text}'}"
        while !check_if_element_exists(query_text)
          scroll("android.support.v4.widget.NestedScrollView", :down)
          wait_for_none_animating
        end
       end
    end
  end
end