class CreateQueries < ActiveRecord::Migration
  def change
    create_table :queries do |t|
      t.integer :user_id
      t.text :output
      t.integer :rows
      t.text :input

      t.timestamps
    end
  end
end
