class CreateResUpvotes < ActiveRecord::Migration
  def change
    create_table :res_upvotes do |t|
      t.integer :user_id
      t.integer :ressource_id

      t.timestamps
    end
  end
end
