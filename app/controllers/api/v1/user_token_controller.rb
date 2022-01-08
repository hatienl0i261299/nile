# frozen_string_literal: true

module Api
  module V1
    class UserTokenController < ApplicationController
      class AuthenticationError < StandardError; end

      rescue_from AuthenticationError, with: :handle_error

      skip_before_action :authenticate_user, only: [:create]

      def create
        raise AuthenticationError unless user.authenticate(params.require(:password))

        token = AuthenticationTokenService.encode(user.id)

        render json: { token: token }, status: :created
      end

      private

      def user
        @user ||= User.find_by(username: params.require(:username))
        @user || (raise AuthenticationError)
      end

      def handle_error
        head :unauthorized
      end
    end
  end
end
