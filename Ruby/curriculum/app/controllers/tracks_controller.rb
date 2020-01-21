class TracksController < ApplicationController
  before_action :authorize, only: [:create, :update, :destroy]

  def index
    endpoint = '/tracks?'
    endpoint += '&sort_by=' + params[:sort_by] if (params[:sort_by] && ['name, asc', 'name, desc', 'created_at, asc', 'created_at, desc'].include?(params[:sort_by]))
    flash[:notice] = "Invalid sorting method" if (params[:sort_by] && !(['name, asc', 'name, desc', 'created_at, asc', 'created_at, desc'].include?(params[:sort_by])))
    endpoint += '&search=' + params[:search] if params[:search]

    @search = true if params[:search]

    response = CurriculumResource.fetch('get', endpoint)

    if (response.code == 404)
      render :not_found
    else
      @tracks = response.map { |response| Track.new(response) }
      @tracks = Kaminari.paginate_array(@tracks).page(params[:page])
      render :index
    end
  end

  def new
    @track = Track.new 
    render :new
  end

  def create
    response = CurriculumResource.fetch('post', '/tracks?', track_params)
    if response.code == 201
      flash[:notice] = "Track added safely!"
      redirect_to tracks_path
    else
      flash[:notice] = "Track could not be added."
      render :new
    end
  end

  def edit
    @track = CurriculumResource.fetch('get', '/tracks/' + params[:id])
    render :edit
  end

  def show
    endpoint = '/tracks/' + params[:id] + '?'
    endpoint += '&lesson_to_add=' + params[:lesson_to_add] if params[:lesson_to_add]
    endpoint += '&lesson_to_remove=' + params[:lesson_to_remove] if params[:lesson_to_remove]

    response = CurriculumResource.fetch('get', endpoint)
    if response.code == 404
      render :not_found
    else
      @track = Track.new(response["track"])
      @related_lessons = response["related_lessons"].map { |lesson| Lesson.new(lesson) }
      @related_lessons = Kaminari.paginate_array(@related_lessons).page(params[:page])
      @lessons = response["lessons"].map { |lesson| Lesson.new(lesson) }
      flash[:notice] = response["flash"]
      render :show
    end
  end

  def update
    response = CurriculumResource.fetch('put', '/tracks/' + params[:id] + '?', track_params)
    if response.code == 200
      flash[:notice] = "Track updated safely!"
      redirect_to tracks_path
    else
      flash[:notice] = "Track could not be updated."
      render :edit
    end
  end

  def destroy    
    response = CurriculumResource.fetch('put', '/tracks/' + params[:id] + '?', track_params)
    if response.code == 200
      flash[:notice] = "Track deleted safely!"
    else
      flash[:notice] = "Track could not be deleted."
    end
    redirect_to tracks_path
  end

  private 
    def track_params
      params.require(:track).permit(:name)
    end

end