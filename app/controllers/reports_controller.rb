class ReportsController < ApplicationController
  def stages_by_year
  	@year=params['year']
    @result = Stage.all.select("strftime('%m',stage_date)").where("strftime('%Y',stage_date) = ?", @year ).group("strftime('%m',stage_date)").order(2).count
    #render json: [{name: 'Count', data: result}]
  end
  def total_by_month
  	@year=params['year']
    @result = Stage.all.select("sum(total),strftime('%m',stage_date)").where("strftime('%Y',stage_date) = ?", @year  ).group("strftime('%m',stage_date)").order(1)
    #render json: [{name: 'Count', data: result}]
  end
end
