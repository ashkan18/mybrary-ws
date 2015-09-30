class AddMediumCoverUrlToBooks < ActiveRecord::Migration
  def change
    add_column :books, :small_medium_url, :string
  end
end
