# frozen_string_literal: true

class AuthorSerializer < ActiveModel::Serializer
  attributes :id, :name, :created_at, :updated_at
  has_many :books
end
