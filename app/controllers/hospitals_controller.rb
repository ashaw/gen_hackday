class HospitalsController < ApplicationController
  respond_to :json

  def show
    @hospital = Hospital.find_by_provider_number(params[:id])
    respond_with @hospital
  end

  def search
    lat = params[:lat].to_f
    lng = params[:lng].to_f
    nearest = Hospital.nearest(lat, lng)
    render :json => nearest.to_json
  end
end