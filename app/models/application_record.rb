# frozen_string_literal: true

require_relative '../common/helper'

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  scope :pagination, lambda { |page_num = 1, per_page = 10|
    page_num = str_to_int(page_num)
    per_page = str_to_int(per_page)
    page = if page_num.present?
             page_num.to_i
           else
             1
           end
    per = if !per_page.present? || per_page.zero?
            10
          else
            per_page
          end
    limit(per).page(page)
  }
end
