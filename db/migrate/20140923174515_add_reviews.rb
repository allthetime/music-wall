class AddReviews < ActiveRecord::Migration
  def change
      create_table "reviews", force: true do |t|
      t.references :user
      t.references :song
      t.string :review
      t.integer :rating, limit: 5
      t.timestamps
    end   
  end
end
