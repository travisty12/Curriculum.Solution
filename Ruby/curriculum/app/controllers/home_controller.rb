class HomeController < ApplicationController
  def index
    # @tracks = Track.all
    # @lessons = Lesson.all 
    # @title = TrackReceiver.get_tracks_restclient
    render :index
  end
end