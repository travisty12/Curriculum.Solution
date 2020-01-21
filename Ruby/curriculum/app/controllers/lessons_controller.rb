class LessonsController < ApplicationController
  before_action :authorize, only: [:create, :update, :destroy]
  
  def index
    p Lesson.limit(10).page(1)
    endpoint = '/lessons?'
    endpoint += '&sort_by=' + params[:sort_by] if (params[:sort_by] && ['title, asc', 'title, desc', 'created_at, asc', 'created_at, desc'].include?(params[:sort_by]))
    flash[:notice] = "Invalid sorting method" if (params[:sort_by] && !(['title, asc', 'title, desc', 'created_at, asc', 'created_at, desc'].include?(params[:sort_by])))
    endpoint += '&search=' + params[:search] if params[:search]
    # endpoint += '&page=' + params[:page] if params[:page]
    @search = true if params[:search]
    @lessons = CurriculumResource.fetch('get', endpoint).map { |response| Lesson.new(response) }
    @lessons = Kaminari.paginate_array(@lessons).page(params[:page])
    
    render :index
  end

  def new
    @lesson = Lesson.new 
    render :new
  end

  def create
    @lesson = Lesson.new(lesson_params)
    if @lesson.save
      flash[:notice] = "Lesson added safely!"
      redirect_to lessons_path
    else
      flash[:notice] = "Lesson could not be added."
      render :new
    end
  end

  def edit
    @lesson = Lesson.find(params[:id])
    render :edit
  end

  def show
    endpoint = '/lessons/' + params[:id] + '?'
    endpoint += '&track_to_add=' + params[:track_to_add] if params[:track_to_add]
    endpoint += '&track_to_remove=' + params[:track_to_remove] if params[:track_to_remove]

    response = CurriculumResource.fetch('get', endpoint)
    p response["related_tracks"]
    @lesson = Lesson.new(response["lesson"])
    @related_tracks = response["related_tracks"].map { |track| Track.new(track) }
    @tracks = response["tracks"].map { |track| Track.new(track) }
    render :show
  end

  def update
    @lesson = Lesson.find(params[:id])
    if @lesson.update(lesson_params)
      flash[:notice] = "Lesson updated safely!"
      redirect_to lessons_path
    else
      flash[:notice] = "Lesson could not be updated."
      render :edit
    end
  end

  def destroy
    @lesson = Lesson.find(params[:id])
    @lesson.destroy
    flash[:notice] = "Lesson deleted safely!"
    redirect_to lessons_path
  end

  private 
    def lesson_params
      params.require(:lesson).permit(:title, :content)
    end

end