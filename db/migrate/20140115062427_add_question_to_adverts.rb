class AddQuestionToAdverts < ActiveRecord::Migration
  def change
    add_column :adverts, :question, :string
  end
end
