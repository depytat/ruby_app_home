class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|

      t.integer :items_count 
      t.timestamps null: false
    end
  end
end
