class AddMoreFields < ActiveRecord::Migration
  def up
    add_column :hospitals, :heart_attack_patients, :integer
    add_column :hospitals, :asprin_at_discharge, :integer
    add_column :hospitals, :asprin_within_30min, :integer
    add_column :hospitals, :fibrinolytic_medication, :integer
    add_column :hospitals, :pci, :integer
    add_column :hospitals, :ecg, :integer
    add_column :hospitals, :asprin, :integer
    add_column :hospitals, :blood_clot_medication, :integer
    add_column :hospitals, :time_to_fibrinolysis, :integer
  end

  def down
    remove_column :hospitals, :heart_attack_patients
    remove_column :hospitals, :asprin_within_30min
    remove_column :hospitals, :asprin_at_discharge
    remove_column :hospitals, :fibrinolytic_medication
    remove_column :hospitals, :pci
    remove_column :hospitals, :ecg
    remove_column :hospitals, :asprin
    remove_column :hospitals, :blood_clot_medication
    remove_column :hospitals, :time_to_fibrinolysis
  end
end
