class CreateBookTransactions < ActiveRecord::Migration
  def change
    create_table :book_transactions do |t|
      t.references :user, index: true, foreign_key: true
      t.references :book_instance, index: true, foreign_key: true
      t.integer :trans_type

      t.timestamps null: false
    end
  end
end
