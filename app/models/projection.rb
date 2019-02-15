class Projection < ApplicationRecord

  # Enable change tracking.
  has_paper_trail

  # Validation.
  validates :projection_date,
            presence: true,
            uniqueness: true
  validates :label,
            presence: true
  validates :goal_weight,
            numericality: { only_integer: true,
                            greater_than: 0 }
  
  # Methods.
  def days_away
    (projection_date - Date.today).to_i
  end
  def weeks_away
    days_away / 7.0
  end
  def closest_measurement
    return nil if projection_date > Date.today
    closest_entry = Entry.where.not(weight: nil).where(["entry_date <= ?", projection_date]).order(entry_date: :desc).first
    return nil if closest_entry.nil?
    closest_entry
  end
  def loss_rate_needed(current)
    return nil if projection_date <= Date.today
    pounds_to_go = current - goal_weight
    return nil if pounds_to_go <= 0
    days_remaining = (projection_date - Date.today).to_i
    weeks_remaining = days_remaining / 7.0
    return pounds_to_go / weeks_remaining
  end

end