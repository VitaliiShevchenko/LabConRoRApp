# frozen_string_literal: true

module CreatorHelper
  def is_creator?(email)
    @user = User.find_by(email:)
    !@user&.creator.nil?
  end
end
