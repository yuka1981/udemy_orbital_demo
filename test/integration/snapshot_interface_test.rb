require 'test_helper'

class SnapshotInterfaceTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:reid)
  end

  test 'snapshot interface' do
    log_in_as(@user)
    get root_path
    assert_select 'div.pagination'
    # invalid submission
    assert_no_difference 'Snapshot.count' do
      post snapshots_path, params: { snapshot: { content: '' } }
    end
    assert_select 'div#error_explanation'
    assert_select 'a[href=?]',  '/?page=2' # correct pagination link

    # valid submission
    content = 'Great demo today!'
    assert_difference 'Snapshot.count', 1 do
      post snapshots_path, params: { snapshot: { content: content } }
    end
    assert_redirected_to root_path
    follow_redirect!
    assert_match content, response.body

    # delete post
    assert_select 'a', text: 'delete'
    first_snapshot = @user.snapshots.paginate(page: 1).first
    assert_difference 'Snapshot.count', -1 do
      delete snapshot_path(first_snapshot)
    end

    # visit differenct user (no delete link)
    get user_path(users(:carol))
    assert_select 'a', text: 'delete', count: 0
  end
end
