# frozen_string_literal: true

module CreatorHelper
  def is_creator?(user_email)
    !Creator.find_by(user_id: User.where(email: user_email).first&.id).nil?
  end
end
