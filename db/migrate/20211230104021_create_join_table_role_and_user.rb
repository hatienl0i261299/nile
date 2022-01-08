class CreateJoinTableRoleAndUser < ActiveRecord::Migration[6.1]
    def change
        create_join_table :users, :roles do |t|

        end
    end
end
