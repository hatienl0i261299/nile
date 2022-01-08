# frozen_string_literal: true

class BookSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :created_at, :updated_at
  has_many :authors
end
