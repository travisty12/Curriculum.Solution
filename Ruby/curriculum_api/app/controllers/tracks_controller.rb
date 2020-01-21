class TracksController < ApplicationController

  def index
    @tracks = Track # Initialize model

    ## Provide filtering options
    method = params[:sort_by].split(', ') if (params[:sort_by] && ['name, asc', 'name, desc', 'created_at, asc', 'created_at, desc'].include?(params[:sort_by]))
    @tracks = @tracks.sort_by_method(method) if (params[:sort_by] && ['name, asc', 'name, desc', 'created_at, asc', 'created_at, desc'].include?(params[:sort_by]))
    @tracks = @tracks.search(params[:search]) if params[:search]

    ## Paginate
    @tracks = @tracks.limit(10).page(params[:page]).per(Track.count)

    json_response(@tracks)
  end
  
  def create
    @track = Track.create!(track_params)
    json_response(@track, :created)
  end

  def show
    response = {} # Initialize return hash
    @track = Track.find(params[:id])
    @flash = ""
    if params[:lesson_to_add] # Add many-to-many relationship
      lesson = Lesson.find(params[:lesson_to_add])
      if @track.lessons.include? lesson 
        @flash = "Relationship already exists!"
      else
        @track.lessons << lesson
      end
    elsif params[:lesson_to_remove] # Remove many-to-many relationship
      lesson = Lesson.find(params[:lesson_to_remove])
      if @track.lessons.include? lesson 
        @track.lessons.delete(lesson)
      else
        @flash = "Relationship does not exist."
      end
    end
    @related_lessons = Lesson.joins(:tracks).where("tracks.id = ?", "#{@track.id}") # Returns track's lessons
    response[:flash] = @flash # Prepare any flash notices
    response[:track] = @track # Return track
    response[:related_lessons] = @related_lessons.limit(10).page(params[:page]).per(@related_lessons.count) # Paginates track's lessons
    response[:lessons] = Lesson.all # Returns ALL lessons, for dropdown view (to add many-to-many relationship)
    json_response(response)
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