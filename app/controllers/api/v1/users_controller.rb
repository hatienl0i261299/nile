# frozen_string_literal: true

require_relative '../../../common/helper'

module Api
  module V1
    class UsersController < ApplicationController
      def index
        active = if params[:active]
                   JSON.parse params[:active]
                 else
                   [true, false]
                 end
        user = User
               .get_info_user
               .where(statuses: { active: active })
               .where("email LIKE '%#{params[:email]}%'")
               .pagination(params[:page], params[:per_page])
        render json: {
          **pagination(user),
          data: user.map { |tmp| UserSerializer.new(tmp).serializable_hash }
        }, adapter: nil, status: :ok
      end

      def show
        user = User.get_info_user.find(params[:id])
        render json: user, status: :ok
      end

      def destroy
        user = User.find(params[:id])
        user.destroy!
        head :no_content
      end

      private

      def user_params
        params.require(:user).permit(:active, :email)
      end
    end
  end
end
