module EntriesHelper

  # Prints separated list.
  def sep_list(*items)
    items.join(' <small class="text-uncolor">/</small> ').html_safe
  end

  # Prints daily flag icon.
  def daily_flag_icon(icon, value, title)
    classes = ["fa-fw"]
    classes << (value ? "text-dark" : "text-uncolor")
    fa_icon(icon, class: classes.join(" "), data: { toggle: "tooltip", title: title })
  end

  # Prints list of daily flag icons.
  def daily_flag_icons(*values)
    items = []
    items << daily_flag_icon("cutlery", values[0], "Tracked Food")
    items << daily_flag_icon("pie-chart", values[1], "Stayed Under Calorie Goal")
    items << daily_flag_icon("heart", values[2], "Closed Move Ring")
    items << daily_flag_icon("bicycle", values[3], "Closed Exercise Ring")
    items << daily_flag_icon("arrow-up", values[4], "Closed Stand Ring")
    items << daily_flag_icon("building", values[5], "Went To Gym")
    items << daily_flag_icon("bed", values[6], "Met Sleep Goal")
    items.join.html_safe
  end

  # Prints grade progress bar.
  def grade_bar(entry)
    score = 0
    score +=1 if entry.tracked_food
    score +=1 if entry.stayed_under_calorie_goal
    score +=1 if entry.closed_move_ring
    score +=1 if entry.closed_exercise_ring
    score +=1 if entry.closed_stand_ring
    score +=1 if entry.went_to_gym
    score +=1 if entry.met_sleep_goal
    progress = 100 * (score / 7.0)
    case score
    when 7
      color = "bg-primary"
    when 5..6
      color = "bg-secondary"
    when 3..4
      color = "bg-warning"
    else
      color = "bg-danger"
    end
    "<div class=\"progress mt-1\"><div class=\"progress-bar progress-bar-striped #{color} progress-bar-animated\" role=\"progressbar\" style=\"width: #{progress}%;\"></div>".html_safe
  end

  # Prints weight change.
  def weight_change(entry)
    change = entry.weight_change
    return if change.nil? || change == 0
    "<br><small class=\"font-weight-bold #{prefer_negative_class(change)}\">#{number_with_precision(change, precision: 1)} #</small>".html_safe
  end

  # Prints measurement changes.
  def measurement_change(entry)
    changes = entry.measurement_changes
    return if changes.nil? || changes.all? {|c| c== 0}
    values = []
    (0..6).each do |i|
      values << "<small class=\"font-weight-bold #{prefer_negative_class(changes[i])}\">#{number_with_precision(changes[i], precision: 1)}&Prime;</small>"
    end
    "<br>#{sep_list values}".html_safe
  end

  # Return text class for number.
  def prefer_negative_class(value)
    case value
    when ->(v) { v < 0 }
      "text-success"
    when ->(v) { v > 0 }
      "text-danger"
    else
      nil
    end
  end

end