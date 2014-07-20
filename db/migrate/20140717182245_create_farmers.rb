class CreateFarmers < ActiveRecord::Migration
  def change
    create_table :farmers do |t|
      t.string :name
      t.string :phone_number
      t.string :location
      t.string :registration_number

      t.timestamps
    end
  end
end
