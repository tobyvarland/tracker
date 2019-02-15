module ProjectionsHelper

  # Calculates weight projection.
  def weight_projection(current, rate, weeks, minimum)
    calc = current + (rate * weeks)
    if calc < minimum
      minimum
    else
      calc
    end
  end

  # Prints summary of finished projection.
  def projection_summary(projection)
    if projection.closest_measurement.nil?
      "<span class=\"text-muted font-italic\">No measurement data.</span>".html_safe
    elsif projection.closest_measurement.weight > projection.goal_weight
      difference = projection.closest_measurement.weight - projection.goal_weight
      "<span class=\"text-danger font-weight-bold\">#{fa_icon "times"} Missed goal by #{pluralize difference, "pound"}: #{projection.closest_measurement.weight} # on #{projection.closest_measurement.entry_date.strftime "%m/%d/%y"}.</span>".html_safe
    else
      "<span class=\"text-success font-weight-bold\">#{fa_icon "check"} Met goal: #{projection.closest_measurement.weight} # on #{projection.closest_measurement.entry_date.strftime "%m/%d/%y"}.</span>".html_safe
    end
  end

end