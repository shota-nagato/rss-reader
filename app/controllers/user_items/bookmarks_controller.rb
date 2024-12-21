class UserItems::BookmarksController < ApplicationController
  before_action :authenticate_user!

  include ActionView::RecordIdentifier

  def update
    user_item = current_user.user_items.find(params[:user_item_id])
    user_item.update!(bookmarked: !user_item.bookmarked)

    respond_to do |format|
      format.turbo_stream {
        render turbo_stream: turbo_stream.replace(
          dom_id(user_item, "bookmark"),
          partial: "user_items/bookmark", locals: {user_item: user_item}
        )
      }
    end
  end
end
