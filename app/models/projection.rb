class Projection < ApplicationRecord

  # Enable change tracking.
  has_paper_trail

  # Validation.
  validates :projection_date,
            presence: true,
            uniqueness: true
  validates :label,
            presence: true
  
  # Methods.
  def days_away
    (projection_date - Date.today).to_i
  end
  def weeks_away
    days_away / 7.0
  end

end