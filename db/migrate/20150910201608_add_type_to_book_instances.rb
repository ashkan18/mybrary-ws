class AddTypeToBookInstances < ActiveRecord::Migration
  def change
    add_column :book_instances, :offer_type, :int
  end
end
