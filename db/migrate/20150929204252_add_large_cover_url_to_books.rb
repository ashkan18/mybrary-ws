class AddLargeCoverUrlToBooks < ActiveRecord::Migration
  def change
    add_column :books, :large_cover_url, :string
  end
end
