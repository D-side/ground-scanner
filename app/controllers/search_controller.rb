class SearchController < ApplicationController
  def coords
    @cities = City.starts_with(params[:prefix]).page(params[:page])
    render :index
  end

  def cities
    point = City.point(
        params[:x].to_f,
        params[:y].to_f
      )
    @cities = City.within(params[:distance], point).page(params[:page])
    render :index
  end
end
