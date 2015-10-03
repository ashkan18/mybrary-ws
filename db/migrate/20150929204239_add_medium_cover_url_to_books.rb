class AddMediumCoverUrlToBooks < ActiveRecord::Migration
  def change
    add_column :books, :medium_cover_url, :string
  end
end
