class AddGoalWeightToProjections < ActiveRecord::Migration[5.2]
  def change
    add_column :projections, :goal_weight, :integer, null: false, default: 0
  end
end