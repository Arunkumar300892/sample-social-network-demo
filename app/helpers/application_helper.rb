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

  def user_avatar(image)
    cl_image_tag(image, width: 45, height: 45, class: 'circle')
  end

  def post_image(image, content)
    watermark_text = Rails.application.credentials.watermark
    cl_image_tag(image,
      transformation: [
        {
          overlay: {
            font_family: 'Times',
            font_size: 16,
            font_style: 'italic',
            font_weight: 'bold',
            text: watermark_text,
          },
          gravity: "south_east", x: 5, y: 5, color: '#ffffff', opacity: '90'
        }
      ],
      class: 'responsive-img materialboxed', data: {caption: content}
    )
  end

end
