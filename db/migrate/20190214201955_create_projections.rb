class CreateProjections < ActiveRecord::Migration[5.2]
  def change
    create_table :projections do |t|
      t.date :projection_date, null: false
      t.string :label, null: false
      t.timestamps
      t.index :projection_date
    end
  end
end