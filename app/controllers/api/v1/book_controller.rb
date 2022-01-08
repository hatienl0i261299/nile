# frozen_string_literal: true

module Api
  module V1
    class BookController < ApplicationController
      def index
        render json: Book.all.to_a, status: :ok
      end

      def display
        id = params[:book_id]
        book = Book.find(id)

        a = 'https://zingmp3.vn/video-clip/Yeu-Nhieu-Ghen-Nhieu-Thanh-Hung/123.html, https://zingmp3.vn/video-clip/Yeu-Nhieu-Ghen-Nhieu-Thanh-Hung/456.html'
        mobj = a.scan(Regexp.new('\/((?:bai-hat|video-clip))\/(.*?)\/(.*?)\W', Regexp::IGNORECASE | Regexp::MULTILINE))
        mobj.map do |_type, _slug, id|
          puts id
        end

        render json: book, status: :ok
      end
    end
  end
end
