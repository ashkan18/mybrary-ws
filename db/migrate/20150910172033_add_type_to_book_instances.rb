class AddTypeToBookInstances < ActiveRecord::Migration
  def change
    add_column :book_instances, :type, :int
  end
end
