class CreateEntries < ActiveRecord::Migration[5.2]
  def change
    create_table :entries do |t|
      t.date :entry_on, null: false
      t.boolean :tracked_food, default: false
      t.boolean :stayed_under_calorie_goal, default: false
      t.boolean :closed_move_ring, default: false
      t.boolean :closed_exercise_ring, default: false
      t.boolean :closed_stand_ring, default: false
      t.boolean :performed_workout, default: false
      t.boolean :met_sleep_goal, default: false
      t.integer :steps, default: nil
      t.integer :total_calories_consumed, default: nil
      t.integer :total_calories_burned, default: nil
      t.integer :active_calories_burned, default: nil
      t.decimal :weight, default: nil, precision: 5, scale: 1
      t.decimal :body_fat, default: nil, precision: 5, scale: 1
      t.decimal :calf_measurement, default: nil, precision: 5, scale: 1
      t.decimal :thigh_measurement, default: nil, precision: 5, scale: 1
      t.decimal :waist_measurement, default: nil, precision: 5, scale: 1
      t.decimal :stomach_measurement, default: nil, precision: 5, scale: 1
      t.decimal :chest_measurement, default: nil, precision: 5, scale: 1
      t.decimal :arm_measurement, default: nil, precision: 5, scale: 1
      t.decimal :neck_measurement, default: nil, precision: 5, scale: 1
      t.text :notes, default: nil
      t.timestamps
      t.index :entry_on
    end
  end
end