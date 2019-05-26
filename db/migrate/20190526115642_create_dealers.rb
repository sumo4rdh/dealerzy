class CreateDealers < ActiveRecord::Migration[5.2]
  def change
    create_table :dealers do |t|
      t.string :nazwa
      t.string :adress
      t.string :telefon
      t.string :miasto
      t.string :wlasciciel
      t.integer :samochody
      t.integer :przychody

      t.timestamps
    end
  end
end
