class CreateAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :addresses do |t|
      t.integer :payer_id
      t.integer :receiver_id
      t.integer :mediator_id
      t.string :key

      t.timestamps
    end
    add_index :addresses, :payer_id
    add_index :addresses, :receiver_id
    add_index :addresses, :mediator_id
  end
end
