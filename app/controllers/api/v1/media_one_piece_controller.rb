# frozen_string_literal: true

require_relative '../../../common/helper'
module Api
  module V1
    class MediaOnePieceController < ApplicationController
      def index
        media_one_piece = MediaOnePiece
                          .get_info_media_one_piece
                          .paging(params[:page], params[:per_page])
                          .left_outer_joins!(:tree)
                          .order(updated_at: :desc)

        render json: {
          **pagination(media_one_piece),
          data: media_one_piece.map { |item| MediaOnePieceSerializer.new(item).serializable_hash }
        }, adapter: nil, status: :ok
      end
    end
  end
end
