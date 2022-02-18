# frozen_string_literal: true

require_relative '../../../common/helper'

module Api
  module V1
    class AuthorController < ApplicationController
      def index
        authors = Author.includes(:books).order(updated_at: :desc).paging(params[:page], params[:per_page])
        render json: {
          **pagination(authors),
          data: authors.map { |item| AuthorSerializer.new(item).serializable_hash }
        }, status: :ok
      end

      def show
        author = Author.includes(:books).order('books.id ASC').find(params[:id])
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
