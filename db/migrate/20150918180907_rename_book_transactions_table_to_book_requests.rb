class RenameBookTransactionsTableToBookRequests < ActiveRecord::Migration
  def change
    rename_table :book_transactions, :book_requests
  end
end
