class LessonsController < ApplicationController

  def index
    
    @lessons = Lesson

    method = params[:sort_by].split(', ') if (params[:sort_by] && ['title, asc', 'title, desc', 'created_at, asc', 'created_at, desc'].include?(params[:sort_by]))
    @lessons = @lessons.sort_by_method(method) if (params[:sort_by] && ['title, asc', 'title, desc', 'created_at, asc', 'created_at, desc'].include?(params[:sort_by]))
    @lessons = @lessons.search(params[:search]) if params[:search]

    @lessons = @lessons.limit(10).page(params[:page])

    json_response(@lessons)
  end
  
  def create
    @lesson = Lesson.create!(lesson_params)
    json_response(@lesson, :created)
  end
  
  def show
    @lesson = Lesson.find(params[:id])
    response = {}
    @flash = ""
    if params[:track_to_add]
      track = Track.find(params[:track_to_add])
      if @lesson.tracks.include? track
        @flash = "Relationship already exists!"
      else
        @lesson.tracks << track
      end
    elsif params[:track_to_remove]
      track = Track.find(params[:track_to_remove])
      if @lesson.tracks.include? track
        @lesson.tracks.delete(track)
      else
        @flash = "Relationship does not exist."
      end
    end
    response[:flash] = @flash
    response[:lesson] = @lesson
    response[:related_tracks] = Track.joins(:lessons).where("lessons.id = ?", "#{@lesson.id}")
    response[:tracks] = Track.all
    json_response(response)
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