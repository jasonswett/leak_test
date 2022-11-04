# MiniTest::Spec data leakage

This repo demonstrates that MiniTest::Spec seems to have a bug that causes data leakage.

To see the demonstration in action, first run `docker compose up -d` and `bin/setup` and then repeatedly run this command:
```bash
rails test test/models/minitest_user_test.rb
```

You'll see that the test outputs a user count which increments with each change.

To make the buggy behavior go away, change `test/models/minitest_user_test.rb` from this:

```ruby
require "test_helper"

describe "user" do
  before do
    puts "User count: #{User.count}"
    puts User.all.map(&:name)
    User.create!(name: SecureRandom.hex)
  end

  it "is the truth" do
    assert true
  end
end
```

To this:

```ruby
require "test_helper"

class Foo;end    # This line was added
describe Foo do  # This line was changed
  before do
    puts "User count: #{User.count}"
    puts User.all.map(&:name)
    User.create!(name: SecureRandom.hex)
  end

  it "is the truth" do
    assert true
  end
end
```

Now repeatedly run the test again and observe that the user count does not increment.

It seems that, for whatever reason, the buggy behavior is present when what follows `describe` is a string and absent when it's a constant. It doesn't seem to matter what the constant is. The key difference seems to be constant versus string.
