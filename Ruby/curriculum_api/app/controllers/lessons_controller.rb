class LessonsController < ApplicationController

  def index
    @lessons = Lesson.all 
    json_response(@lessons)
  end
  
end