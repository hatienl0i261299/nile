# frozen_string_literal: true

module Api
  module V1
    class StatusController < ApplicationController
      def index
        render json: Status.all, status: :ok
      end
    end
  end
end
