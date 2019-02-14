class Entry < ApplicationRecord

  # Enable change tracking.
  has_paper_trail

  # Validation.
  validates :entry_on,
            presence: true,
            uniqueness: true
  validates :steps,
            :total_calories_consumed,
            :total_calories_burned,
            :active_calories_burned,
            numericality: { only_integer: true,
                            greater_than: 0 },
            allow_nil: true
  validates :weight,
            :body_fat,
            :calf_measurement,
            :thigh_measurement,
            :waist_measurement,
            :stomach_measurement,
            :chest_measurement,
            :arm_measurement,
            :neck_measurement,
            numericality: { greater_than: 0 },
            allow_nil: true
  validate  :require_all_calories_if_any,
            :require_all_measurements_if_any
  
  # Custom validation methods.
  def require_all_calories_if_any
    return if total_calories_consumed.nil? && total_calories_burned.nil? && active_calories_burned.nil?
    msg = "must be entered if entering calories"
    errors.add(:total_calories_consumed, msg) if total_calories_consumed.nil?
    errors.add(:total_calories_burned, msg) if total_calories_burned.nil?
    errors.add(:active_calories_burned, msg) if active_calories_burned.nil?
  end
  def require_all_measurements_if_any
    return if calf_measurement.nil? && thigh_measurement.nil? && waist_measurement.nil? && stomach_measurement.nil? && chest_measurement.nil? && arm_measurement.nil? && neck_measurement.nil?
    msg = "must be entered if entering measurements"
    errors.add(:calf_measurement, msg) if calf_measurement.nil?
    errors.add(:thigh_measurement, msg) if thigh_measurement.nil?
    errors.add(:waist_measurement, msg) if waist_measurement.nil?
    errors.add(:stomach_measurement, msg) if stomach_measurement.nil?
    errors.add(:chest_measurement, msg) if chest_measurement.nil?
    errors.add(:arm_measurement, msg) if arm_measurement.nil?
    errors.add(:neck_measurement, msg) if neck_measurement.nil?
  end

  # Callbacks.
  after_initialize :make_for_today, if: :new_record?
  def make_for_today
    self.entry_on ||= Date.today
  end

  # Methods.
  def calories_entered?
    return !total_calories_consumed.nil?
  end
  def measurements_entered?
    return !calf_measurement.nil?
  end
  def weight_change
    return nil if weight.nil?
    previous = Entry.where.not(weight: nil, id: id).where(["entry_on < ?", entry_on]).order(entry_on: :desc).first
    return nil if previous.nil?
    return weight - previous.weight
  end
  def body_fat_change
    return nil if body_fat.nil?
    previous = Entry.where.not(body_fat: nil, id: id).where(["entry_on < ?", entry_on]).order(entry_on: :desc).first
    return nil if previous.nil?
    return body_fat - previous.body_fat
  end
  def measurement_changes
    return nil if calf_measurement.nil?
    previous = Entry.where.not(calf_measurement: nil, id: id).where(["entry_on < ?", entry_on]).order(entry_on: :desc).first
    return nil if previous.nil?
    return [
      calf_measurement - previous.calf_measurement,
      thigh_measurement - previous.thigh_measurement,
      waist_measurement - previous.waist_measurement,
      stomach_measurement - previous.stomach_measurement,
      chest_measurement - previous.chest_measurement,
      arm_measurement - previous.arm_measurement,
      neck_measurement - previous.neck_measurement
    ]
  end
  def flag_score
    score = 0
    score += 1 if tracked_food
    score += 1 if stayed_under_calorie_goal
    score += 1 if closed_move_ring
    score += 1 if closed_exercise_ring
    score += 1 if closed_stand_ring
    score += 1 if performed_workout
    score += 1 if met_sleep_goal
    return score
  end
  def bmi
    return nil if weight.nil?
    return 703 * weight / 4830.25
  end
  def bmi_change
    return nil if weight.nil?
    previous = Entry.where.not(weight: nil, id: id).where(["entry_on < ?", entry_on]).order(entry_on: :desc).first
    return nil if previous.nil?
    return bmi - previous.bmi
  end
  def attributes
    super.merge({ bmi: bmi })
  end

end