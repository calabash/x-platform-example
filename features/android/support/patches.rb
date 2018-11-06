require "calabash-android"

=begin
These methods are implemented for Calabash-ios.
We are implementing their Android equivalents if possible so some of them may be empty.
=end


module Calabash
  module Android
    module WaitHelpers
      def wait_for_none_animating(*args)
        sleep 1
      end
    end

    module Operations
      def scroll_to_row_with_mark(text)
        query_text = "* {text CONTAINS[c] '#{text}'}"
        while(!check_if_element_exists(query_text))
          scroll("android.support.v4.widget.NestedScrollView", :down)
          sleep 0.2
        end
       end
    end
  end
end