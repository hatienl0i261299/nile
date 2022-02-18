class LolChampion < ApplicationRecord
  include MeiliSearch::Rails
  belongs_to :tree

  meilisearch do
    attribute :name
    attribute :location
    attribute :quote
    attribute :summoner_spell

    filterable_attributes [:location]
    sortable_attributes [:created_at, :updated_at]
  end
end
