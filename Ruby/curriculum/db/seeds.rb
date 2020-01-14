# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Track.destroy_all
Lesson.destroy_all

5.times do |track_index|
  Track.create!(name: Faker::Lorem.word)
  10.times do |lesson_index|
    lesson = Lesson.create!(title: Faker::Lorem.sentence(word_count: 3), content: Faker::Lorem.paragraph(sentence_count: 5))
    (track_index + 1).times do 
      offset = rand(Track.count)
      track = Track.offset(offset).first 
      if track.lessons.include? lesson
      else
        track.lessons << lesson
      end
    end
  end
end

p "Created #{Track.count} tracks and #{Lesson.count} lessons"