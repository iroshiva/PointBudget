# frozen_string_literal: true

module Admin
  class ApplicationController < ::ApplicationController
    before_action :only_admin

    private

    def only_admin
      return if user_signed_in? && current_user.is_admin == true

      flash[:error] = 'You\'re not allowed on this page'
      redirect_to root_path
    end
  end
end
