class LolChampionSerializer < ApplicationSerializer
  attributes :id,
             :name,
             :location,
             :quote,
             :summoner_spell,
             :tree,
             :created_at,
             :updated_at

  # def tree
  #   {
  #     id: object.tree_id,
  #     name: object.tree_name
  #   }
  # end

end
