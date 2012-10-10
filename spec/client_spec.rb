require 'spec_helper'

describe EpaUvIndex::Client do
  
  it "should return an array for a daily zip code request" do
    response = EpaUvIndex::Client.daily_for(:zip => '21209')
    response.is_a?(Array).should be_true
    response.first["ZIP_CODE"].should == 21209
    response.first["UV_INDEX"].should == 4
    response.first["UV_ALERT"].should == 0
  end
end
