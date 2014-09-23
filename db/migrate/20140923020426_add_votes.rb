class AddVotes < ActiveRecord::Migration
  def change
    create_table "votes", force: true do |t|
      t.references :user
      t.references :song
      t.timestamps
    end    
  end
end
