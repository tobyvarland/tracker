# Page load handler.
$(document).on 'turbolinks:load', ->

  # Auto dismiss alerts after 2 seconds.
  setTimeout dismiss_alerts, 2000

  # Enable popovers & tooltips.
  $('[data-toggle="tooltip"]').tooltip()

  # Setup chart drawing.
  google.charts.load('current', {'packages':['line']});
  google.charts.setOnLoadCallback(draw_weight_chart);

# Draws weight chart.
draw_weight_chart = ->

  # Reference container.
  container = $("#weight-chart")
  #console.log container.height()
  #console.log container.width()

  # Load entries.
  entries = container.data("entries")
  #console.log entries

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
  #console.log rows
  data.addRows rows

  # Set options.
  options = {
    chart: {
      title: 'Weight'
    },
    width: container.width(),
    height: container.height()
  };
  #console.log options

  # Draw chart.
  chart = new google.charts.Line(document.getElementById('weight-chart'));
  chart.draw(data, google.charts.Line.convertOptions(options));

# Automatically dismisses alerts.
dismiss_alerts = ->
  $(".alert").alert('close')