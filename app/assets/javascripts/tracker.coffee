# Page load handler.
$(document).on 'turbolinks:load', ->

  # Auto dismiss alerts after 2 seconds.
  setTimeout dismiss_alerts, 2000

  # Enable popovers & tooltips.
  $('[data-toggle="tooltip"]').tooltip()

  # Setup chart drawing.
  google.charts.load('current', {'packages':['line']});
  google.charts.setOnLoadCallback(draw_weight_chart);
  $("#chart-list").on
    'shown.bs.tab': (e)->
      val = $(e.target)
      switch val.attr('id')
        when "chart-tab-calories" then draw_calorie_chart()
        when "chart-tab-weight" then draw_weight_chart()
        when "chart-tab-steps" then draw_step_chart()
        when "chart-tab-measurements" then draw_measurement_chart()

# Draws weight chart.
draw_weight_chart = ->

  # Reference container.
  container = $("#weight-chart")

  # Load entries.
  entries = container.data("entries")

  # Set up data table object.
  data = new google.visualization.DataTable();
  data.addColumn('date', 'Date');
  data.addColumn('number', 'Weight');

  # Add data to table.
  rows = []
  for e in entries
    if e.weight != ""
      parts = e.entry_on.split "-"
      rows.push [new Date(parts[0], parts[1] - 1, parts[2]), parseFloat(e.weight)]
  data.addRows rows

  # Set options.
  options = {
    curveType: "function",
    width: container.width(),
    height: container.width() * 0.2,
    hAxis: {
      title: "Date",
      format: "MM/dd/yy"
    },
    legend: {
      position: "none"
    },
    titlePosition: "none",
    vAxis: {
      title: "Pounds",
      format: "decimal",
      maxValue: 350,
      minValue: 200,
      viewWindow: {
        max: 350,
        min: 200
      }
    }
  }

  # Draw chart.
  chart = new google.charts.Line(document.getElementById('weight-chart'));
  chart.draw(data, google.charts.Line.convertOptions(options));

# Draws calorie chart.
draw_calorie_chart = ->

  # Reference container.
  container = $("#weight-chart")

  # Load entries.
  entries = container.data("entries")

  # Set up data table object.
  data = new google.visualization.DataTable();
  data.addColumn('date', 'Date');
  data.addColumn('number', 'Total Consumed');
  data.addColumn('number', 'Total Burned');
  data.addColumn('number', 'Active Burned');

  # Add data to table.
  rows = []
  for e in entries
    if e.total_calories_consumed?
      parts = e.entry_on.split "-"
      rows.push [new Date(parts[0], parts[1] - 1, parts[2]), e.total_calories_consumed, e.total_calories_burned, e.active_calories_burned]
  data.addRows rows

  # Set options.
  options = {
    curveType: "function",
    width: container.width(),
    height: container.width() * 0.2,
    hAxis: {
      title: "Date",
      format: "MM/dd/yy"
    },
    titlePosition: "none",
    vAxis: {
      title: "Calories",
      format: "decimal",
      minValue: 0,
      viewWindow: {
        min: 0
      }
    }
  }

  # Draw chart.
  chart = new google.charts.Line(document.getElementById('calorie-chart'));
  chart.draw(data, google.charts.Line.convertOptions(options));

# Draws step chart.
draw_step_chart = ->

  # Reference container.
  container = $("#weight-chart")

  # Load entries.
  entries = container.data("entries")

  # Set up data table object.
  data = new google.visualization.DataTable();
  data.addColumn('date', 'Date');
  data.addColumn('number', 'Steps');

  # Add data to table.
  rows = []
  for e in entries
    if e.steps?
      parts = e.entry_on.split "-"
      rows.push [new Date(parts[0], parts[1] - 1, parts[2]), e.steps]
  data.addRows rows

  # Set options.
  options = {
    curveType: "function",
    width: container.width(),
    height: container.width() * 0.2,
    hAxis: {
      title: "Date",
      format: "MM/dd/yy"
    },
    titlePosition: "none",
    vAxis: {
      title: "Steps",
      format: "decimal",
      minValue: 0,
      viewWindow: {
        min: 0
      }
    }
  }

  # Draw chart.
  chart = new google.charts.Line(document.getElementById('step-chart'));
  chart.draw(data, google.charts.Line.convertOptions(options));

# Draws measurement chart.
draw_measurement_chart = ->

  # Reference container.
  container = $("#weight-chart")

  # Load entries.
  entries = container.data("entries")

  # Set up data table object.
  data = new google.visualization.DataTable();
  data.addColumn('date', 'Date');
  data.addColumn('number', 'Calf');
  data.addColumn('number', 'Thigh');
  data.addColumn('number', 'Waist');
  data.addColumn('number', 'Stomach');
  data.addColumn('number', 'Shoulders');
  data.addColumn('number', 'Arm');
  data.addColumn('number', 'Neck');

  # Add data to table.
  rows = []
  for e in entries
    if e.calf_measurement?
      parts = e.entry_on.split "-"
      rows.push [
        new Date(parts[0], parts[1] - 1, parts[2]),
        parseFloat(e.calf_measurement),
        parseFloat(e.thigh_measurement),
        parseFloat(e.waist_measurement),
        parseFloat(e.stomach_measurement),
        parseFloat(e.shoulder_measurement),
        parseFloat(e.arm_measurement),
        parseFloat(e.neck_measurement)
      ]
  data.addRows rows

  # Set options.
  options = {
    curveType: "function",
    width: container.width(),
    height: container.width() * 0.2,
    hAxis: {
      title: "Date",
      format: "MM/dd/yy"
    },
    titlePosition: "none",
    vAxis: {
      title: "Inches",
      format: "decimal",
      minValue: 0,
      viewWindow: {
        min: 0
      }
    }
  }

  # Draw chart.
  chart = new google.charts.Line(document.getElementById('measurement-chart'));
  chart.draw(data, google.charts.Line.convertOptions(options));

# Automatically dismisses alerts.
dismiss_alerts = ->
  $(".alert").alert('close')