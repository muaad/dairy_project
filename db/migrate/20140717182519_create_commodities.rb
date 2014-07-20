class CreateCommodities < ActiveRecord::Migration
  def change
    create_table :commodities do |t|
      t.string :name
      t.string :commodity_type
      t.string :units

      t.timestamps
    end
  end
end
