
class MessagesRepresenter
    def initialize(messages)
        @messages = messages
    end

    def as_json
        {
            data: @messages
        }
        # {
        #     count: @messages.length,
        #     data: @messages.map do |message|
        #         {
        #             id: message.id,
        #             user_id: message.user.id,
        #             first_name: message.user.first_name,
        #             last_name: message.user.last_name,
        #             email: message.user.email,
        #             content: message.content,
        #             read: message.read,
        #             active: message.user.status.active,
        #             created_at: message.created_at.strftime("%Y/%m/%d %H:%M:%S"),
        #             updated_at: message.updated_at.strftime("%Y/%m/%d %H:%M:%S")
        #         }
        #     end
        # }
    end

end
