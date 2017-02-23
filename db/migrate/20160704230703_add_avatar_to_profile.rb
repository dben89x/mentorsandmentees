class AddAvatarToProfile < ActiveRecord::Migration
  def up
    add_attachment :intern_profiles, :avatar
    add_attachment :startup_profiles, :avatar
  end

  def down
    remove_attachment :intern_profiles, :avatar
    remove_attachment :startup_profiles, :avatar
  end
end
