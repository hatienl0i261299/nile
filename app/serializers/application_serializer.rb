# frozen_string_literal: true

class ApplicationSerializer < ActiveModel::Serializer
  def created_at
    object.created_at.strftime('%H:%M:%S %d-%m-%Y')
  end

  def updated_at
    object.updated_at.strftime('%H:%M:%S %d-%m-%Y')
  end
end
