class Entry < ApplicationRecord

  # Validation.
  validates :steps,
            :total_calories_consumed,
            :total_calories_burned,
            :active_calories_burned,
            numericality: { only_integer: true,
                            greater_than: 0 },
            allow_nil: true
  validates :weight,
            :calf_measurement,
            :thigh_measurement,
            :waist_measurement,
            :stomach_measurement,
            :shoulder_measurement,
            :arm_measurement,
            :neck_measurement,
            numericality: { greater_than: 0 },
            allow_nil: true

end