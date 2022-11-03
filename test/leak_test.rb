class DoesItLeakTest < ActiveSupport::TestCase
  test "leak" do
    assert_equal 1, 1
  end
end
