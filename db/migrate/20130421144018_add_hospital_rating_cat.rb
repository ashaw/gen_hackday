class AddHospitalRatingCat < ActiveRecord::Migration
  def up
    add_column :hospitals, :hospital_rating_str, :string
  end

  def down
    remove_column :hospitals, :hospital_rating_str
  end
end
