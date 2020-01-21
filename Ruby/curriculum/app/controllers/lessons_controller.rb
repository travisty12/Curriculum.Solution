class LessonsController < ApplicationController
  before_action :authorize, only: [:create, :update, :destroy]
  
  def index
    endpoint = '/lessons?'
    endpoint += '&sort_by=' + params[:sort_by] if (params[:sort_by] && ['title, asc', 'title, desc', 'created_at, asc', 'created_at, desc'].include?(params[:sort_by]))
    flash[:notice] = "Invalid sorting method" if (params[:sort_by] && !(['title, asc', 'title, desc', 'created_at, asc', 'created_at, desc'].include?(params[:sort_by])))
    endpoint += '&search=' + params[:search] if params[:search]

    @search = true if params[:search]

    response = CurriculumResource.fetch('get', endpoint)

    if (response.code == 404)
      render :not_found
    else
      @lessons = response.map { |response| Lesson.new(response) }
      @lessons = Kaminari.paginate_array(@lessons).page(params[:page])
      render :index
    end
  end

  def new
    @lesson = Lesson.new 
    render :new
  end

  def create
    response = CurriculumResource.fetch('post', '/lessons?', lesson_params)
    if response.code == 201
      flash[:notice] = "Lesson added safely!"
      redirect_to lessons_path
    else
      flash[:notice] = "Lesson could not be added."
      render :new
    end
  end

  def edit
    @lesson = CurriculumResource.fetch('get', '/lessons/' + params[:id])
    render :edit
  end

  def show
    endpoint = '/lessons/' + params[:id] + '?'
    endpoint += '&track_to_add=' + params[:track_to_add] if params[:track_to_add]
    endpoint += '&track_to_remove=' + params[:track_to_remove] if params[:track_to_remove]

    response = CurriculumResource.fetch('get', endpoint)
    if response.code == 404
      render :not_found
    else
      @lesson = Lesson.new(response["lesson"])
      @related_tracks = response["related_tracks"].map { |track| Track.new(track) }
      @tracks = response["tracks"].map { |track| Track.new(track) }
      flash[:notice] = response["flash"]
      render :show
    end
  end

  def update
    response = CurriculumResource.fetch('put', '/lessons/' + params[:id] + '?', lesson_params)
    if response.code == 200
      flash[:notice] = "Lesson updated safely!"
      redirect_to lessons_path
    else
      flash[:notice] = "Lesson could not be updated."
      render :edit
    end
  end

  def destroy
    response = CurriculumResource.fetch('delete', '/lessons/' + params[:id])
    if response.code == 200
      flash[:notice] = "Lesson deleted safely!"
    else
      flash[:notice] = "Lesson could not be deleted."
    end
    redirect_to lessons_path
  end

  private 
    def lesson_params
      params.require(:lesson).permit(:title, :content)
    end

end