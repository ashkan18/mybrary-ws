class AddStatusToBookInstances < ActiveRecord::Migration
  def change
    add_column :book_instances, :status, :integer
  end
end
