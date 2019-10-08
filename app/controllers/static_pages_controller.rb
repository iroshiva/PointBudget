# frozen_string_literal: true

class StaticPagesController < ApplicationController
  before_action :hide_nav_user
  def landing_page; end

  def about; end

  def hide_nav_user
    @nav_user = false
  end
end
