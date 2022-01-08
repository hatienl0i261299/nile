# frozen_string_literal: true

# MessageSerializer
class MessageSerializer < ApplicationSerializer
  attributes :id,
             :content,
             :read,
             :user_id,
             :username,
             :full_name,
             :email,
             :user_activated,
             :status_id,
             :created_at,
             :updated_at

  def user_activated
    object.active
  end

  def full_name
    "#{object.first_name} #{object.last_name}"
  end
end
