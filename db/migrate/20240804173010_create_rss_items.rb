class CreateRssItems < ActiveRecord::Migration[7.0]
  def change
    create_table :rss_items do |t|
      t.string :title
      t.string :link
      t.text :summary
      t.datetime :published_at

      t.timestamps
    end
  end
end
