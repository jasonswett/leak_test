require "test_helper"

describe User do
  before do
    puts "User count: #{User.count}"
    puts User.all.map(&:name)
    User.create!(name: SecureRandom.hex)
  end

  it "is the truth" do
    assert true
  end
end
