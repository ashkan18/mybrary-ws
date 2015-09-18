class AddStatusToBookTransactions < ActiveRecord::Migration
  def change
    add_column :book_transactions, :status, :integer
  end
end
