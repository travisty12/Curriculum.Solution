class TracksController < ApplicationController

  def index
    if params[:sort_by]
      case params[:sort_by]
      when 'name, asc', 'name, desc', 'created_at, asc', 'created_at, desc'
        method = params[:sort_by].split(', ')
        @tracks = Track.sort_by_method(method)
      else
        flash[:notice] = "Invalid sorting method"
        @tracks = Track.all
      end
    elsif params[:search]
      @tracks = Track.search(params[:search])
      @search = true
    else
      @tracks = Track.all
    end
    
    render :index
  end

  def new
    @track = Track.new 
    render :new
  end

  def create
    @track = Track.new(track_params)
    if @track.save
      flash[:notice] = "Track added safely!"
      redirect_to tracks_path
    else
      flash[:notice] = "Track could not be added."
      render :new
    end
  end

  def edit
    @track = Track.find(params[:id])
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