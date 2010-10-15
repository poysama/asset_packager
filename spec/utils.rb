require "spec_helper"

describe "Utils" do

  it "should stringify keys" do
    hash = {:option => 'hello', 'another_one' => 'world'}

    Palmade::AssetPackager::Utils.stringify_keys(hash).should == {
      'option' => 'hello',
      'another_one' => 'world'
    }
  end

end

