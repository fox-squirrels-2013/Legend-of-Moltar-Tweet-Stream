class CreateTweetCounts < ActiveRecord::Migration
  def change
    create_table :tweet_counts do |t|
      t.integer :coffee, default: 0
      t.integer :tea, default: 0
      t.integer :dbcsleeps, default: 0
      t.integer :canada, default: 0
    end
  end
end
