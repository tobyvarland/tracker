class Milestone < ApplicationRecord

  # Enable change tracking.
  has_paper_trail

  # Validation.
  validates :label,
            presence: true

end