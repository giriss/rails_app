class AddAnswersToAdverts < ActiveRecord::Migration
  def change
    add_column :adverts, :answers, :text
  end
end
