# frozen_string_literal: true

class User < ApplicationRecord
  belongs_to :status
  belongs_to :group
  has_many :books
  has_many :messages, dependent: :nullify
  has_one :ticket, dependent: :nullify
  has_and_belongs_to_many :roles
  has_secure_password

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP, message: "'%{value}' is not a valid email" }

  scope :username_similar, lambda { |username|
    quoted_username = ActiveRecord::Base.connection.quote_string(username)
    where("username ~ '^#{username}.'")
      .order(Arel.sql("similarity(username, '#{quoted_username}') DESC"))
  }

  scope :get_info_user, lambda {
    includes(:status, :ticket, :group, :roles).order(id: :asc)
  }
end
