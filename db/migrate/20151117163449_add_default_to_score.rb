class AddDefaultToScore < ActiveRecord::Migration
  def change
    change_column :scores, :points, :integer, default: 0r
  end
end
