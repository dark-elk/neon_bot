# frozen_string_literal: true
#
module Commands
  class Unknown < Base
    MESSAGE_TEXT = "Не удалось распознать команду"

    private

    def handle_call(message)
      api.send_message(
          chat_id: message.chat.id,
          text: MESSAGE_TEXT,
          parse_mode: :markdown
      )
    end

    def handle_callback(callback, args)
      api.answer_callback_query(
          callback_query_id: callback.message.chat.id,
          text: MESSAGE_TEXT
      )
    end
  end
end
