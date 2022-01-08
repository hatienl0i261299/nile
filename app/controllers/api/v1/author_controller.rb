# frozen_string_literal: true

module Api
  module V1
    class AuthorController < ApplicationController
      def index
        render json: Author.select('authors.id, authors.name, authors.created_at, authors.updated_at')
                           .order(id: :asc), status: :ok
      end

      def display
        author = Author.find(params[:author_id])
        render json: author, status: :ok
      end
    end
  end
end
