class CreateDeliveries < ActiveRecord::Migration
  def change
    create_table :deliveries do |t|
      t.references :commodity, index: true
      t.references :farmer, index: true
      t.integer :quantity
      t.float :price
      t.float :total
      t.boolean :paid_for

      t.timestamps
    end
  end
end
