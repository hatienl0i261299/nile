class LolChampion < ApplicationRecord
  belongs_to :tree

  # include MeiliSearch::Rails
  # meilisearch do
  #   attribute :name
  #   attribute :location
  #   attribute :quote
  #   attribute :summoner_spell
  #
  #   filterable_attributes [:location]
  #   sortable_attributes [:created_at, :updated_at]
  # end
end
