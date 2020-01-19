class LessonsController < ApplicationController

  def index
    @lessons = Lesson.all 
    json_response(@lessons)
  end

  def show
    @lesson = Lesson.find(params[:id])
    json_response(@lesson)
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