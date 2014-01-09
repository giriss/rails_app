class CreateAnnouncements < ActiveRecord::Migration
  def change
    create_table :announcements do |t|
      t.string :title
      t.string :body
      t.string :for

      t.timestamps
    end
  end
end
