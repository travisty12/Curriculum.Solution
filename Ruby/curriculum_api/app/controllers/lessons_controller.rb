class LessonsController < ApplicationController

  def index
    
    @lessons = Lesson

    method = params[:sort_by].split(', ') if (params[:sort_by] && ['title, asc', 'title, desc', 'created_at, asc', 'created_at, desc'].include?(params[:sort_by]))
    @lessons = @lessons.sort_by_method(method) if (params[:sort_by] && ['title, asc', 'title, desc', 'created_at, asc', 'created_at, desc'].include?(params[:sort_by]))
    @lessons = @lessons.search(params[:search]) if params[:search]

    @lessons = @lessons.limit(10).page(params[:page])

    json_response(@lessons)
  end

  def show
    @lesson = Lesson.find(params[:id])
    if params[:track_to_add]
      track = Track.find(params[:track_to_add])
      if @lesson.tracks.include? track
        # flash[:notice] = "Relationship already exists!"
      else
        @lesson.tracks << track
      end
    elsif params[:track_to_remove]
      track = Track.find(params[:track_to_remove])
      if @lesson.tracks.include? track
        @lesson.tracks.delete(track)
      else
        # flash[:notice] = "Relationship does not exist."
      end
    end
    @related_tracks = Track.joins(:lessons).where("lessons.id = ?", "#{@lesson.id}")
    @tracks = Track.all
    json_response({lesson: @lesson, related_tracks: @related_tracks, tracks: @tracks})
  end

  def create
    @lesson = Lesson.create!(lesson_params)
    json_response(@lesson, :created)
  end

  def update
    @lesson = Lesson.find(params[:id])
    if @lesson.update!(lesson_params)
      json_response({message: "The lesson has been successfully updated."}, :ok)
    end
  end

  def destroy
    @lesson = Lesson.find(params[:id])
    if @lesson.destroy!
      json_response({message: "The lesson has been successfully destroyed."}, :ok)
    end
  end

  private

  def lesson_params
    params.permit(:title, :content)
  end
  
end