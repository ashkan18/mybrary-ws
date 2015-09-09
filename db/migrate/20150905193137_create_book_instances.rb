class CreateBookInstances < ActiveRecord::Migration
  def change
    create_table :book_instances do |t|
      t.references :user, index: true, foreign_key: true
      t.references :book, index: true, foreign_key: true
      t.decimal :lat
      t.decimal :lon

      t.timestamps null: false
    end
  end
end
