class LinebotController < ApplicationController
  require 'line/bot'

  skip_before_action :verify_authenticity_token
  before_action :validate_signature, except: [:new, :create]

  def validate_signature
    body = request.body.read
    signature = request.env['HTTP_X_LINE_SIGNATURE']
    unless client.validate_signature(body, signature)
      error 400 do 'Bad Request' end
    end
  end

  def callback
    body = request.body.read
    events = client.parse_events_from(body)
    events.each { |event|
      case event
      when Line::Bot::Event::Message
        case event.type
        when Line::Bot::Event::MessageType::Text
          texts = event.message['text'].split(",")

          return unless SpendReason.find_by(name: texts[0])
          reason = SpendReason.find_by(name: texts[0])

          wallet = Wallet.first
          if Wallet.find_by(name: texts[1])
            wallet = Wallet.find_by(name: texts[1])
          end

          amount = texts[2].to_i
          userId = event['source']['userId']

          spend = Spend.new(amount: amount, wallet_id: wallet.id, spend_reason_id: reason.id,
            user_id: userId.delete("^0-9").to_i)
          spend.save!

          message = {
            type: 'text',
            text: reason.name + 'を' + wallet.name + 'から' + amount.to_s + '円使った。'
          }
          client.push_message(userId, message)
        end
      when Line::Bot::Event::Follow
        userId = event['source']['userId']
        displayName = 'LINEから'
        User.find_or_create_by(id: userId.delete("^0-9").to_i, name: displayName.to_s)
        message_text = displayName.to_s + 'のユーザー情報を登録しました。'
        message = {
          type: 'text',
          text: message_text
        }
        puts userId + 'に' + message_text + 'と言います。'
        client.push_message(userId, message)
      when Line::Bot::Event::Unfollow
        userId = event['source']['userId']
        displayName = 'LINEから'
        user = User.find_by(id: userId.delete("^0-9").to_i)
        user.destroy if user.present?
        message_text = displayName.to_s + 'のユーザー情報を削除しました。'
        message = {
          type: 'text',
          text: message_text
        }
        puts userId + 'に' + message_text + 'と言います。'
        client.push_message(userId, message)
      end
    }
    head :ok
  end

  def client
    @client ||= Line::Bot::Client.new { |config|
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    }
  end
end
