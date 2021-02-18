# frozen_string_literal: true

module Commands
  module Form
    class Sample < Protected

      private

      SAMPLE_TEXT =
          "Иванова Елена 1000+271+706+292=2269\n5536 2214 2300 8412\n\n" +
              "Борисова Е. 1681 15 60 3620 (271)\n5536 0000 0000 1560\n\n" +
              "Измайлова Т. 4183 230 60 9420 (706)\n5536 0000 0000 6731\n\n" +
              "Шувалова А. 1458 367 60 3896 (292)\n5536 0000 0000 1147\n\n" +
              "💡 Сперва указывается имя и фамилия администратора, в данном примере это Иванова Елена. Далее указывается оклад - 1000 рублей, затем плюсуются процентные начисления с каждой модели. Процент составляет 7,5% . Все это необходимо посчитать самому, от заработка моделей из CRM.\n\n" +
              "Далее указываются расчеты моделей, сперва ее фамилия и первая буква имени, затем количество ее заработанных токенов. Если порталов с токенами много, то они указываются через пробел. Затем указывается ставка модели и ее расчет. Всю эту информацию можно скопировать из CRM. В скобочках необходимо указать процентное начисление с модели по ставке указанной выше. В следующей строчке необходимо указать карту модели, из ее профиля в CRM."

      def handle_call(message)
        send_message(
            chat_id: message.chat.id,
            text: SAMPLE_TEXT,
            parse_mode: :markdown,
            )
      end
    end
  end
end
