class TracksController < ApplicationController

  def index
    @tracks = Track.all 
    json_response(@tracks)
  end

  def show
    @track = Track.find(params[:id])
    json_response(@track)
  end

  def create
    @track = Track.create!(track_params)
    json_response(@track, :created)
  end

  def update
    @track = Track.find(params[:id])
    if @track.update!(track_params)
      json_response({message: "The track has been successfully updated."}, :ok)
    end
  end

  def destroy
    @track = Track.find(params[:id])
    if @track.destroy!
      json_response({message: "The track has been successfully destroyed."}, :ok)
    end
  end

  private

  def track_params
    params.permit(:name)
  end
  
end