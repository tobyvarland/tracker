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

end