class AddLargeCoverUrlToBooks < ActiveRecord::Migration
  def change
    add_column :books, :small_large_url, :string
  end
end
