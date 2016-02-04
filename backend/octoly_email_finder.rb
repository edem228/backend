require "json"
class Octoly_email_finder 
  def initialize(file)
    @file = file
    @number_for_email = number_for_email
  end

  def read_file
    File.read(@file)
  end

  def parsed_file
    JSON.parse(read_file)
  end

  def counts_videos_by_id
    most_viewed_topics = []
    parsed_file.each do |video|
      video["topic_ids"].each do |id|
        if most_viewed_topics.any? {|topic| topic.include?(id)}
          index = most_viewed_topics.index {|topic| topic[id]}
          most_viewed_topics[index][id] += video["views_count"]
          most_viewed_topics[index]["like"] += video["likes_count"]
          most_viewed_topics[index]["dislike"] += video["dislikes_count"]
        else 
          most_viewed_topics << {id => video["views_count"], "like" => video["likes_count"], "dislike" => video["dislikes_count"]}
        end
      end
    end
    most_viewed_topics
  end

  def max_by_value
    counts_videos_by_id.max_by{|key,value| value}
  end
  def number_for_email
    max_by_value.values.inject(:*)
  end
end
def octoly_email
  Octoly_email_finder.new("videos.json").number_for_email.to_s + "@octoly.com"
end

puts octoly_email