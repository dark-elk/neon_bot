# frozen_string_literal: true

module Commands
  module Keyboards
    class MainKeyboard
      include KeyboardHelpers

      def call
        buttons = [
            button('Образец формы'),
            button('Опубликовать')
        ]
        reply_keyboard(buttons, opts: { resize_keyboard: true })
      end
    end
  end
end
