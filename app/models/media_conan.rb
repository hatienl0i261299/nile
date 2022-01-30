class MediaConan < ApplicationRecord
  belongs_to :tree

  scope :get_info_media_conan, lambda {
    select(
      [
        'media_conans.id',
        'media_conans.character',
        'media_conans.gadget',
        'media_conans.vehicle',
        'media_conans.created_at',
        'media_conans.updated_at',
        'trees.id as tree_id',
        'trees.name as tree_name',
      ].join(', ')
    )
  }
end
