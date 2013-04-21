class AddRatingFields < ActiveRecord::Migration
  def up
    add_column :hospitals, :emergency_department, :boolean
    add_column :hospitals, :open, :boolean
    add_column :hospitals, :beds, :integer
    add_column :hospitals, :heart_care_rating, :float
  end

  def down
    remove_column :hospitals, :emergency_department, :boolean
    remove_column :hospitals, :open, :boolean
    remove_column :hospitals, :beds, :integer
    remove_column :hospitals, :heart_care_rating, :float
  end
end
