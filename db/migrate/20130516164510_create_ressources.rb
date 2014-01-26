class CreateRessources < ActiveRecord::Migration
  def change
    create_table :ressources do |t|
      t.string :title
      t.text :link
      t.string :type
      t.integer :user_id
      t.integer :community_id

      t.timestamps
    end
  end
end
