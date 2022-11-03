require "test_helper"

class UserTest < ActiveSupport::TestCase
  setup do
    puts "User count: #{User.count}"
    puts User.all.map(&:name)
    User.create!(name: SecureRandom.hex)
  end

  test "the truth" do
    assert true
  end
end
