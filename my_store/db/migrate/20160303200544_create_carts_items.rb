class CreateCartsItems < ActiveRecord::Migration
  # def change
  #   create_table :carts_items do |t|
  #   end
  # end




  def self.up
    create_table :carts_items, id: false do |t|
      t.references :cart
      t.references :item
    end

    add_index :carts_items, [:item_id, :cart_id]
    add_index :carts_items, [:cart_id, :item_id]
  end

  def self.down
    drop_table :carts_items
  end
end
