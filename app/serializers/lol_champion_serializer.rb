class LolChampionSerializer < ApplicationSerializer
  attributes :id,
             :name,
             :location,
             :quote,
             :summoner_spell,
             :tree,
             :created_at,
             :updated_at
  belongs_to :tree
end
