class LessonsController < ApplicationController

  def index
    # if params[:sort_by]
    #   case params[:sort_by]
    #   when 'name, asc', 'name, desc', 'created_at, asc', 'created_at, desc'
    #     method = params[:sort_by].split(', ')
    #     @tracks = Track.sort_by_method(method)
    #   else
    #     flash[:notice] = "Invalid sorting method"
    #     @tracks = Track.all
    #   end
    # elsif params[:search]
    #   @tracks = Track.search(params[:search])
    #   @search = true
    # else
      @lessons = Lesson.all
    # end
    
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
      params.require(:lesson).permit(:name)
    end

end