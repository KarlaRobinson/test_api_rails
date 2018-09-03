class CreateCompanies < ActiveRecord::Migration[5.2]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :category
      t.boolean :activated, default: false

      t.timestamps
    end
  end
end
