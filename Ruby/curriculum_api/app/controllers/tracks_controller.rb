class TracksController < ApplicationController

  def index
    @tracks = Track.all
    json_response(@tracks)
  end

  private
end