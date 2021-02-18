# frozen_string_literal: true

module Commands
  module Form
    class Publish < Protected
      include Import[:settings]

      private

      def handle_call(message)
        settings.telegram_authorized_ids.map do |uid|
          send_message(
              chat_id: uid,
              text: "sample",
          )
        end
      end
    end
  end
end
