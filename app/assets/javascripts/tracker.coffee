# Page load handler.
$(document).on 'turbolinks:load', ->

  # Auto dismiss alerts after 2 seconds.
  setTimeout dismiss_alerts, 2000

  # Enable popovers & tooltips.
  $('[data-toggle="tooltip"]').tooltip()

  # Build charts when necessary.
  if $("body").hasClass("action-charts")
    draw_charts()

# Handles debug message.
debug = (msg)->
  return
  console.log msg

# Draws charts.
draw_charts = ->

  # Print beginning message.
  debug "Drawing charts."

  # Load Google objects.
  debug "Loading Google objects."
  google.charts.load  "current",
                      {
                        "packages": ["line"]
                      }
  google.charts.setOnLoadCallback process_charts

# Helper for drawing charts.
process_charts = ->

  # Print beginning message.
  debug "Processing charts."

  # Read data.
  data_container = $("#chart-data")
  raw_entries = data_container.data "entries"
  debug raw_entries

  # Format entry dates.
  debug "Formatting entry dates."
  for entry in raw_entries
    do ->
      date_parts = entry.entry_on.split "-"
      entry.formatted_date = new Date(date_parts[0], date_parts[1] - 1, date_parts[2])
  debug raw_entries

  # Reference chart containers.
  weight_chart_container = $("#weight-chart")
  calorie_chart_container = $("#calorie-chart")
  step_chart_container = $("#step-chart")
  measurement_chart_container = $("#measurement-chart")
  body_fat_chart_container = $("#body-fat-chart")

  # Build Google data tables for charts.
  debug "Building Google data tables."
  weight_table = get_weight_data_table raw_entries
  calorie_table = get_calorie_data_table raw_entries
  step_table = get_step_data_table raw_entries
  measurement_table = get_measurement_data_table raw_entries
  body_fat_table = get_body_fat_data_table raw_entries

  # Retrieve chart options.
  debug "Retrieving chart options."
  weight_options = get_weight_chart_options weight_chart_container.width()
  calorie_options = get_calorie_chart_options calorie_chart_container.width()
  step_options = get_step_chart_options step_chart_container.width()
  measurement_options = get_measurement_chart_options measurement_chart_container.width()
  body_fat_options = get_body_fat_chart_options body_fat_chart_container.width()

  # Draw charts.
  debug "Drawing charts."
  if weight_table.getNumberOfRows() < 2
    weight_chart_container.html "<p class=\"mt-3 p-3 rounded border bg-light text-muted text-center small font-italic\">Not enough data to graph weight &amp; BMI.</p>"
  else
    weight_chart = new google.charts.Line(document.getElementById('weight-chart'))
    weight_chart.draw(weight_table, google.charts.Line.convertOptions(weight_options))
  if calorie_table.getNumberOfRows() < 2
    calorie_chart_container.html "<p class=\"mt-3 p-3 rounded border bg-light text-muted text-center small font-italic\">Not enough data to graph calories.</p>"
  else
    calorie_chart = new google.charts.Line(document.getElementById('calorie-chart'))
    calorie_chart.draw(calorie_table, google.charts.Line.convertOptions(calorie_options))
  if step_table.getNumberOfRows() < 2
    step_chart_container.html "<p class=\"mt-3 p-3 rounded border bg-light text-muted text-center small font-italic\">Not enough data to graph steps.</p>"
  else
    step_chart = new google.charts.Line(document.getElementById('step-chart'))
    step_chart.draw(step_table, google.charts.Line.convertOptions(step_options))
  if measurement_table.getNumberOfRows() < 2
    measurement_chart_container.html "<p class=\"mt-3 p-3 rounded border bg-light text-muted text-center small font-italic\">Not enough data to graph measurements.</p>"
  else
    measurement_chart = new google.charts.Line(document.getElementById('measurement-chart'))
    measurement_chart.draw(measurement_table, google.charts.Line.convertOptions(measurement_options))
  if body_fat_table.getNumberOfRows() < 2
    body_fat_chart_container.html "<p class=\"mt-3 p-3 rounded border bg-light text-muted text-center small font-italic\">Not enough data to graph body fat.</p>"
  else
    body_fat_chart = new google.charts.Line(document.getElementById('body-fat-chart'))
    body_fat_chart.draw(body_fat_table, google.charts.Line.convertOptions(body_fat_options))

# Formats data table for weight chart.
get_weight_data_table = (entries)->

  # Create Google data table.
  table = new google.visualization.DataTable();
  table.addColumn('date', 'Date');
  table.addColumn('number', 'Weight');
  table.addColumn('number', 'BMI');

  # Add data to table.
  rows = []
  for entry in entries
    do ->
      if entry.weight? && entry.weight != ""
        rows.push [
          entry.formatted_date,
          parseFloat(entry.weight),
          parseFloat(entry.bmi)
        ]
  table.addRows rows
  return table

# Formats data table for calorie chart.
get_calorie_data_table = (entries)->

  # Create Google data table.
  table = new google.visualization.DataTable();
  table.addColumn('date', 'Date');
  table.addColumn('number', 'Total Consumed');
  table.addColumn('number', 'Total Burned');
  table.addColumn('number', 'Active Burned');

  # Add data to table.
  rows = []
  for entry in entries
    do ->
      if entry.total_calories_consumed?
        rows.push [
          entry.formatted_date,
          entry.total_calories_consumed,
          entry.total_calories_burned,
          entry.active_calories_burned
        ]
  table.addRows rows
  return table

# Formats data table for step chart.
get_step_data_table = (entries)->

  # Create Google data table.
  table = new google.visualization.DataTable();
  table.addColumn('date', 'Date');
  table.addColumn('number', 'Steps');

  # Add data to table.
  rows = []
  for entry in entries
    do ->
      if entry.steps?
        rows.push [
          entry.formatted_date,
          entry.steps
        ]
  table.addRows rows
  return table

# Formats data table for measurement chart.
get_measurement_data_table = (entries)->

  # Create Google data table.
  table = new google.visualization.DataTable();
  table.addColumn('date', 'Date');
  table.addColumn('number', 'Calf');
  table.addColumn('number', 'Thigh');
  table.addColumn('number', 'Waist');
  table.addColumn('number', 'Stomach');
  table.addColumn('number', 'Chest');
  table.addColumn('number', 'Arm');
  table.addColumn('number', 'Neck');

  # Add data to table.
  rows = []
  for entry in entries
    do ->
      if entry.calf_measurement? && entry.calf_measurement != ""
        rows.push [
          entry.formatted_date,
          parseFloat(entry.calf_measurement),
          parseFloat(entry.thigh_measurement),
          parseFloat(entry.waist_measurement),
          parseFloat(entry.stomach_measurement),
          parseFloat(entry.chest_measurement),
          parseFloat(entry.arm_measurement),
          parseFloat(entry.neck_measurement)
        ]
  table.addRows rows
  return table

# Formats data table for body fat chart.
get_body_fat_data_table = (entries)->

  # Create Google data table.
  table = new google.visualization.DataTable();
  table.addColumn('date', 'Date');
  table.addColumn('number', 'Body Fat');

  # Add data to table.
  rows = []
  for entry in entries
    do ->
      if entry.body_fat? && entry.body_fat != ""
        rows.push [
          entry.formatted_date,
          parseFloat(entry.body_fat)
        ]
  table.addRows rows
  return table

# Returns chart options for weight chart.
get_weight_chart_options = (width)->

  # Set options for weight chart.
  options = {
    axes: {
      y: {
        Weight: {
          label: "Pounds"
        },
        BMI: {
          label: "BMI"
        }
      }
    },
    curveType: "function",
    width: width,
    height: width * 0.5,
    hAxis: {
      title: "Date",
      format: "MM/dd/yy"
    },
    series: {
      0: { axis: "Weight" },
      1: { axis: "BMI" }
    },
    title: "Weight & BMI",
    titlePosition: "top"
  }
  return options

# Returns chart options for calorie chart.
get_calorie_chart_options = (width)->

  # Set options for weight chart.
  options = {
    curveType: "function",
    width: width,
    height: width * 0.5,
    hAxis: {
      title: "Date",
      format: "MM/dd/yy"
    },
    title: "Calories",
    titlePosition: "top",
    vAxis: {
      title: "Calories",
      format: "decimal",
      minValue: 0,
      viewWindow: {
        min: 0
      }
    }
  }
  return options

# Returns chart options for step chart.
get_step_chart_options = (width)->

  # Set options for weight chart.
  options = {
    curveType: "function",
    width: width,
    height: width * 0.5,
    hAxis: {
      title: "Date",
      format: "MM/dd/yy"
    },
    title: "Steps",
    titlePosition: "top",
    vAxis: {
      title: "Steps",
      format: "decimal",
      minValue: 0,
      viewWindow: {
        min: 0
      }
    }
  }
  return options

# Returns chart options for measurement chart.
get_measurement_chart_options = (width)->

  # Set options for weight chart.
  options = {
    curveType: "function",
    width: width,
    height: width * 0.5,
    hAxis: {
      title: "Date",
      format: "MM/dd/yy"
    },
    title: "Measurements",
    titlePosition: "top",
    vAxis: {
      title: "Inches",
      format: "decimal",
      minValue: 0,
      viewWindow: {
        min: 0
      }
    }
  }
  return options

# Returns chart options for body fat chart.
get_body_fat_chart_options = (width)->

  # Set options for weight chart.
  options = {
    curveType: "function",
    width: width,
    height: width * 0.5,
    hAxis: {
      title: "Date",
      format: "MM/dd/yy"
    },
    title: "Body Fat",
    titlePosition: "top",
    vAxis: {
      title: "%",
      format: "decimal",
      minValue: 0,
      viewWindow: {
        min: 0
      }
    }
  }
  return options

# Automatically dismisses alerts.
dismiss_alerts = ->
  $(".alert").alert('close')