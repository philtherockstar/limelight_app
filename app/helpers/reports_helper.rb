module ReportsHelper

  def stages_this_year
    line_chart stages_this_year_reports_path, library: {
      title: {text: 'Stages by year', x: -20},
      yAxis: {
          crosshair: true,
          title: {
              text: 'Stages'
          }
      },
      xAxis: {
          crosshair: true,
          title: {
              text: 'Year'
          }
      }
    }
  end

end
