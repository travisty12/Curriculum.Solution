class LessonsController < ApplicationController

  def index
    @lessons = Lesson

    method = params[:sort_by].split(', ') if (params[:sort_by] && ['title, asc', 'title, desc', 'created_at, asc', 'created_at, desc'].include?(params[:sort_by]))
    @lessons = @lessons.sort_by_method(method) if (params[:sort_by] && ['title, asc', 'title, desc', 'created_at, asc', 'created_at, desc'].include?(params[:sort_by]))
    flash[:notice] = "Invalid sorting method" if (params[:sort_by] && !(['title, asc', 'title, desc', 'created_at, asc', 'created_at, desc'].include?(params[:sort_by])))
    @lessons = @lessons.search(params[:search]) if params[:search]
    @search = true if params[:search]

    @lessons = @lessons.limit(10).page(params[:page])
    
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
    @lesson = Lesson.find(params[:id])
    if params[:track_to_add]
      track = Track.find(params[:track_to_add])
      if @lesson.tracks.include? track
        flash[:notice] = "Relationship already exists!"
      else
        @lesson.tracks << track
      end
    elsif params[:track_to_remove]
      track = Track.find(params[:track_to_remove])
      if @lesson.tracks.include? track
        @lesson.tracks.delete(track)
      else
        flash[:notice] = "Relationship does not exist."
      end
    end
    @tracks = Track.all
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