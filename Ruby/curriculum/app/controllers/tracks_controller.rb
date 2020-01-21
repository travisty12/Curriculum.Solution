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
    @track = Track.find(params[:id])
    if params[:lesson_to_add]
      lesson = Lesson.find(params[:lesson_to_add])
      if @track.lessons.include? lesson
        flash[:notice] = "Relationship already exists!"
      else
        @track.lessons << lesson
      end
    elsif params[:lesson_to_remove]
      lesson = Lesson.find(params[:lesson_to_remove])
      if @track.lessons.include? lesson
        @track.lessons.delete(lesson)
      else
        flash[:notice] = "Relationship does not exist."
      end
    end
    @lessons = Lesson.all
    render :show
  end

  def update
    @track = Track.find(params[:id])
    if @track.update(track_params)
      flash[:notice] = "Track updated safely!"
      redirect_to tracks_path
    else
      flash[:notice] = "Track could not be updated."
      render :edit
    end
  end

  def destroy
    @track = Track.find(params[:id])
    @track.destroy
    flash[:notice] = "Track deleted safely!"
    redirect_to tracks_path
  end

  private 
    def track_params
      params.require(:track).permit(:name)
    end

end