class Admin::ApplicationController < ActionController::Base
  before_action :authenticate_admin

  def authenticate_admin
    redirect_to "/" unless user_signed_in? && current_user.admin?
  end
end
