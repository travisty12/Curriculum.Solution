class AddLessonsAndHasManyThroughTable < ActiveRecord::Migration[5.2]
  def change
    create_table :lessons do |t|
      t.string :title
      t.string :content
      t.timestamps
    end
    create_table :lesson_tracks do |t|
      t.belongs_to :lesson, index: true 
      t.belongs_to :track, index: true
      t.timestamps
    end
  end
end
