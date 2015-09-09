class AddLocationToBookInstances < ActiveRecord::Migration
  def change
    add_column :book_instances, :location, :point
  end
end
