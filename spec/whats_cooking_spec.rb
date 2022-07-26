require './whats_cooking'

def capture_stdout(&block)
  original_stdout = $stdout
  $stdout = fake = StringIO.new
  begin
    yield
  ensure
    $stdout = original_stdout
  end
  fake.string
end

describe WhatsCooking do
  context "When testing the WhatsCooking class" do
    # it "Should return WhatsCooking" do
    #   true.should eq(false)
    # end
  end
end
