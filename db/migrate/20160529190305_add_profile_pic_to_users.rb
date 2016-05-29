class AddProfilePicToUsers < ActiveRecord::Migration
  def change
    add_column :users, :profile_picture_url, :string
  end
end
