require "test_helper"

class BackupControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get backup_index_url
    assert_response :success
  end
end
