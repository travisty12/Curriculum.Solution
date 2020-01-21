class TracksController < ApplicationController

  def index
    @tracks = Track # Initialize model

    ## Provide filtering options
    method = params[:sort_by].split(', ') if (params[:sort_by] && ['name, asc', 'name, desc', 'created_at, asc', 'created_at, desc'].include?(params[:sort_by]))
    @tracks = @tracks.sort_by_method(method) if (params[:sort_by] && ['name, asc', 'name, desc', 'created_at, asc', 'created_at, desc'].include?(params[:sort_by]))
    @tracks = @tracks.search(params[:search]) if params[:search]

    ## Paginate
    @tracks = @tracks.limit(10).page(params[:page])
    
    json_response(@tracks)
  end

  def show
    @track = Track.find(params[:id])
    @related_lessons = Lesson.joins(:tracks).where("tracks.id = ?", "#{@track.id}")
    json_response({track: @track, related_lessons: @related_lessons})
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