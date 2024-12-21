class UserItems::LikesController < ApplicationController
  before_action :authenticate_user!

  include ActionView::RecordIdentifier

  def update
    user_item = current_user.user_items.find(params[:user_item_id])
    user_item.update(liked: !user_item.liked)

    respond_to do |format|
      format.turbo_stream {
        render turbo_stream: turbo_stream.replace(
          dom_id(user_item, "like"),
          partial: "user_items/like", locals: {user_item: user_item}
        )
      }
    end
  end
end
