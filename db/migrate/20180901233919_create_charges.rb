class CreateCharges < ActiveRecord::Migration[5.2]
  def change
    create_table :charges do |t|
      t.integer :amount, limit: 8
      t.string :payment_type
      t.string :detail
      t.references :company, foreign_key: true

      t.timestamps
    end
  end
end
