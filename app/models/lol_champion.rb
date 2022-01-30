class LolChampion < ApplicationRecord
  belongs_to :tree

  scope :get_info_lol_champion, lambda {
    select(
      [
        'lol_champions.id',
        'lol_champions.name',
        'lol_champions.location',
        'lol_champions.quote',
        'lol_champions.summoner_spell',
        'lol_champions.created_at',
        'lol_champions.updated_at',
        'trees.id as tree_id',
        'trees.name as tree_name'
      ].join(', ')
    )
  }
end
