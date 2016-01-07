module ApplicationHelper
  def signed_in_as_admin?
    signed_in? && current_user.admin?
  end
end
