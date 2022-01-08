# frozen_string_literal: true

require_relative '../../../common/helper'

module Api
  module V1
    class TicketController < ApplicationController
      def get_ticket
        ticket = Ticket.joins(:user).where("LOWER(tickets.match) LIKE '%#{ params[:match] ? params[:match].downcase : '' }%'")
                       .pagination(params[:page], params[:per_page])
        render json: {
          **pagination(ticket),
          data: ticket.map { |item| TicketSerializer.new(item).serializable_hash }
        }, adapter: nil, status: :ok
      end

      private

      def ticket_params
        params.require(:ticket).permit(:match)
      end
    end
  end
end
