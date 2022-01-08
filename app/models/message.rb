# frozen_string_literal: true

class Message < ApplicationRecord
  belongs_to :user

  scope :content_contain, lambda { |content|
    where(%"lower(content) like '%#{content.present? ? content.downcase : ''}%'")
  }

  scope :active_true, lambda {
    where(statuses: { active: true })
  }
end
