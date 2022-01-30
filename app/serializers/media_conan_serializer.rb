class MediaConanSerializer < ApplicationSerializer
  attributes :id,
             :character,
             :gadget,
             :vehicle,
             :tree,
             :created_at,
             :updated_at

  def tree
    {
      id: object.tree_id,
      name: object.tree_name
    }
  end
end
