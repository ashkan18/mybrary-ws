class AddTransValueToBookTransactions < ActiveRecord::Migration
  def change
    add_column :book_transactions, :trans_value, :float
  end
end
