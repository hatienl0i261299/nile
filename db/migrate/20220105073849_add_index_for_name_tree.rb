class AddIndexForNameTree < ActiveRecord::Migration[6.1]
  def change
    add_index :trees, :name
  end
end
