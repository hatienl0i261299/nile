# frozen_string_literal: true

module Api
  module V1
    class AuthorController < ApplicationController
      def index
        render json: Author.select('authors.id, authors.name, authors.created_at, authors.updated_at')
                           .order(id: :asc), status: :ok
      end

      def show
        author = Author.find(params[:id])
        render json: author, status: :ok
      end

      def destroy
        author = Author.find(params[:id])
        author.destroy!
        head :no_content
      end
    end
  end
end
