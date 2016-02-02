require "json"
file =  File.read('videos.json')
hash = JSON.parse(file)
videos = []
hash.each do |item|
  videos << item
end

most_viewed = videos.map.sort_by do |i|
   i["views_count"]
end.last

result = most_viewed["views_count"] * most_viewed["likes_count"] * most_viewed["dislikes_count"] * most_viewed["topic_ids"].count

puts result.to_s + "@octoly.com"