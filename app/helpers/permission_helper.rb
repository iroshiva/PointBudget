# frozen_string_literal: true

module PermissionHelper
  def admin?
    user_signed_in? && current_user.is_admin == true
  end
end
