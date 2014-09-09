class ReviewDecorator < Draper::Decorator
  delegate_all

  def author
    review.user_id = user.id
    user.firstname + ' ' + user.lastname
  end

end
