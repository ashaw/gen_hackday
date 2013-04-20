class CreateInitialDb < ActiveRecord::Migration
  def up
    create_table :hospitals do |t|
     t.string "provider_number"
     t.string "hospital_name"
     t.string "address_1"
     t.string "address_2"
     t.string "address_3"
     t.string "city"
     t.string "state"
     t.string "zip_code"
     t.string "county_name"
     t.integer "phone_number"
     t.float :heart_attack_mortality_rate
     t.float :lat, :limit => 8
     t.float :lng, :limit => 8
    end
  end

  def down
    drop_table :hospitals
  end
end
