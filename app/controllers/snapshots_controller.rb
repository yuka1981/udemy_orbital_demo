class SnapshotsController < ApplicationController
  before_action :logged_in_user, only: %i[create destroy]
  before_action :correct_user,  only: %i[destroy]

  def create
    @snapshot = current_user.snapshots.build(snapshot_params)
    @snapshot.image.attach(params[:snapshot][:image])

    if @snapshot.save
      flash[:success] = 'Snapshot created'
      redirect_to root_path
    else
      @feed_items = current_user.feed.paginate(page: params[:page])
      render 'html_pages/home'
    end
  end

  def destroy
    @snapshot.destroy
    flash[:success] = 'Deleted successfully'
    # request.referer => 發送表單、點擊連結的情況下，會在 request 中記錄使用者當前的 url
    redirect_to request.referer || root_path
  end

  private

  def snapshot_params
    params.require(:snapshot).permit(:content, :image)
  end

  def correct_user
    @snapshot = current_user.snapshots.find_by(id: params[:id])
    redirect_to root_path if @snapshot.nil?
  end

  # Move to application controller
  # def logged_in_user
  #   return if logged_in?

  #   store_location
  #   flash[:danger] = 'Please log in.'
  #   redirect_to login_url
  # end
end
