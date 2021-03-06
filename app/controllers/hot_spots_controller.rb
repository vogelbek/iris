class HotSpotsController < ApplicationController
  before_action :set_start, :set_end

  def hot_spots_index
    @hot_spots = HotSpot.all.map do |spot|
      City.new  spot.id, spot.city, spot.lat, spot.long,
                count_photos_per_date_scale( spot, @start_time, @end_time )
    end
  end

  def hot_spot_index
    spot = HotSpot.find(params[:id])
    photos = time_limit_photos( spot, @start_time, @end_time )
    @hot_spot = City.new  spot.id, spot.city, spot.lat, spot.long,
                          tidy_photos( photos )
  end

  private

  def set_start
    date = params[:start_date].split '-'
    year = date[0].to_i
    month = date[1].to_i
    day = date[2].to_i
    @start_time = DateTime.new year, month, day
  end

  def set_end
    date = params[:end_date].split '-'
    year = date[0].to_i
    month = date[1].to_i
    day = date[2].to_i
    @end_time = DateTime.new year, month, day
  end

  def time_increment start_time, end_time
    increments = 10 # Guessing at correct number
    period = end_time - start_time
    (period / increments).to_f
  end

  def build_date_scale start_time, end_time
    scale = (1..10).map do |segment|
      increment = time_increment( start_time, end_time )
      segment_start = (start_time + (segment - 1) * increment).to_f
      segment_end = (start_time + segment * increment).to_f
      segment_midpoint = (segment_start + segment_end) / 2
      [Time.at( segment_start ),  Time.at( segment_midpoint ),
                                  Time.at( segment_end )]
    end
    scale
  end

  def count_photos_in_date_increment hot_spot, start_time, end_time
    current = hot_spot.photos.where('datetime BETWEEN ? AND ?',
                                    start_time, end_time).all
    current.inject(0) do |sum, photo|
      sum += 1
    end
  end

  def count_photos_per_date_scale hot_spot, start_time, end_time
    scale = build_date_scale( start_time, end_time )
    scale.map do |increment|
      count = count_photos_in_date_increment( hot_spot,
                                              increment[0],
                                              increment[2] )
      Segment.new increment[0], increment[1], increment[2], count
    end
  end

  def tidy_photos photos_list
    photos_list.map do |photo|
      Photo.new photo.id, photo.url, photo.datetime
    end
  end

  def time_limit_photos hot_spot, start_time, end_time
    hot_spot.photos.where('datetime BETWEEN ? AND ?',
                          start_time, end_time).all
  end

  Segment = Struct.new :start, :midpoint, :end, :count
  City = Struct.new :id, :city, :lat, :long, :photo_info
  Photo = Struct.new :id, :url, :datetime
end
