# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130421144018) do

  create_table "hospitals", :force => true do |t|
    t.string  "provider_number"
    t.string  "hospital_name"
    t.string  "address_1"
    t.string  "address_2"
    t.string  "address_3"
    t.string  "city"
    t.string  "state"
    t.string  "zip_code"
    t.string  "county_name"
    t.integer "phone_number"
    t.float   "heart_attack_mortality_rate"
    t.float   "lat"
    t.float   "lng"
    t.integer "heart_attack_patients"
    t.integer "asprin_at_discharge"
    t.integer "asprin_within_30min"
    t.integer "fibrinolytic_medication"
    t.integer "pci"
    t.integer "ecg"
    t.integer "asprin"
    t.integer "blood_clot_medication"
    t.integer "time_to_fibrinolysis"
    t.boolean "emergency_department"
    t.boolean "open"
    t.integer "beds"
    t.float   "heart_care_rating"
    t.string  "hospital_rating_str"
  end

end
