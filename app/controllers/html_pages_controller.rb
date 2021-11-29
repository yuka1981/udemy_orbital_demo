class HtmlPagesController < ApplicationController
  def home
    return unless logged_in?

    @feed_items = current_user.feed.paginate(page: params[:page])
    @snapshot = current_user.snapshots.build if logged_in?
  end

  def help; end

  def about; end

  def contact; end
end
