class CreateMilestones < ActiveRecord::Migration[5.2]
  def change
    create_table :milestones do |t|
      t.string :label, null: false
      t.date :milestone_date, default: nil
      t.text :notes, default: nil
      t.timestamps
    end
  end
end