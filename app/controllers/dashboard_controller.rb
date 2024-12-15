class DashboardController < ApplicationController
  def show
    @items = current_user.items.where(published_at: Date.current.beginning_of_day..Date.current.end_of_day).distinct.order(published_at: :desc)
  end
end
