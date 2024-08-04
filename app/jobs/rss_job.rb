class RssJob < ApplicationJob
  queue_as :default

  def perform
    feed = Feedjira::Feed.fetch_and_parse("https://feeds.feedburner.com/magyaritasok_hu")

    feed.entries.each do |entry|
      RssItem.create!(
        title: entry.title,
        link: entry.url,
        summary: entry.summary,
        published_at: entry.published
      )
    end
  end
end