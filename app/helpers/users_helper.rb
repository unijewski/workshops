module UsersHelper

  # Returns the Gravatar (http://gravatar.com/) for the given user.
  def gravatar_for(user)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, alt: user.firstname, class: "gravatar")
  end

  def last_reviews(user)
    Review.where(user_id: user.id).order(created_at: :desc).last(5)
  end
end
