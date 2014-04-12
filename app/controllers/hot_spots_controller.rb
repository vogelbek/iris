class HotSpotsController < ApplicationController
  def hot_spots_index
    @hot_spots = HotSpot.all
  end

  private
  def hot_spot_params
    params.require(:hot_spot).permit(:id, :start_time, :end_time)
  end
end
