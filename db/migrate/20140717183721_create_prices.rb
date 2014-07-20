class CreatePrices < ActiveRecord::Migration
  def change
    create_table :prices do |t|
      t.references :commodity, index: true
      t.float :price

      t.timestamps
    end
  end
end
