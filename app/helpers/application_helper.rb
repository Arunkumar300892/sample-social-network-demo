module ApplicationHelper

  def like_unlike(post, user)
    already_liked = post.likes.find { |like| like.user_id == user.id }
  end

  def time_ago time, append = ' ago'
    return time_ago_in_words(time).gsub(/about|less than|almost|over/, '').strip << append
  end

  def count_with_text(count, type)
    text = count == 1 ? (type) : (type + 's')
    return "#{count} #{text}"
  end

end
