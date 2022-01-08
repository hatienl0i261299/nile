# frozen_string_literal: true

require_relative '../../../common/helper'

module Api
  module V1
    class MessageController < ApplicationController
      def index
        read = if params[:read]
                 JSON.parse(params[:read])
               else
                 [true, false]
               end

        active = if params[:active]
                   JSON.parse(params[:active])
                 else
                   [nil, true, false]
                 end

        list_email = params[:email] ? params[:email].split(',') : []

        message = Message
                  .pagination(params[:page], params[:per_page])
                  .left_outer_joins(user: :status)
                  .select([
                    'messages.id',
                    'messages.content',
                    'messages.read',
                    'messages.user_id',
                    'users.username',
                    'users.first_name',
                    'users.last_name',
                    'users.email',
                    'statuses.active',
                    'users.status_id',
                    'messages.created_at',
                    'messages.updated_at'
                  ].map(&:strip).join(', '))
                  .content_contain(params[:content])
                  .where(read: read)
                  .where(list_email.map { |email| "users.email LIKE '%#{email.strip}%'" }.join(' OR '))
                  .where(statuses: { active: active })
                  .order(updated_at: :asc)
        render json: {
          **pagination(message),
          data: message.map { |temp| MessageSerializer.new(temp).serializable_hash }
        }, adapter: nil, status: :ok
      end

      def search_test
        message = Message.where(%(content LIKE '%#{params[:content]}%'))
        render json: message, status: :ok
      end

      private

      def book_params
        params.require(:book).permit(:content, :read, :page, :per_page)
      end
    end
  end
end
