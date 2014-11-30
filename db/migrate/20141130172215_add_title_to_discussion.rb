class AddTitleToDiscussion < ActiveRecord::Migration
  def change
    add_column :discussions, :title, :string
  end
end
