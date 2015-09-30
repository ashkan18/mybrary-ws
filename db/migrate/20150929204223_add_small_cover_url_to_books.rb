class AddSmallCoverUrlToBooks < ActiveRecord::Migration
  def change
    add_column :books, :small_cover_url, :string
  end
end
