# frozen_string_literal: true

require_relative '../../../common/helper'
module Api
  module V1
    class MediaConanController < ApplicationController
      def index
        media_conan = MediaConan
                      .get_info_media_conan
                      .paging(params[:page], params[:per_page])
                      .left_joins(:tree)
                      .order(updated_at: :desc)

        render json: {
          **pagination(media_conan),
          data: media_conan.map { |item| MediaConanSerializer.new(item).serializable_hash }
        }, adapter: nil, status: :ok
      end
    end
  end
end
