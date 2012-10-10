require 'spec_helper'

describe EpaUvIndex::Client do
  
  describe "#daily_for" do
    context "when querying for a daily UV index for a zip code" do
      context "when neither a zip nor a city/state are passed as parameters" do
        it "should raise an exception" do
          lambda { EpaUvIndex::Client.daily_for(:city => 'Baltimore')}.should raise_error "Please provide either a city/state or a zip code."
        end
      end
      
      context "when the response is good" do
        before do
          response = mock(Object)
          response.stub!(:body).and_return '[{"ZIP_CODE":21209,"UV_INDEX":3,"UV_ALERT":0}]'
          response.stub!(:code).and_return 200
          HTTParty.should_receive(:get).with("http://iaspub.epa.gov/enviro/efservice/getEnvirofactsUVDAILY/ZIP/21209/json").and_return response
        end

        it "should return an array for a daily zip code request" do
          response = EpaUvIndex::Client.daily_for(:zip => '21209')
          response.is_a?(Array).should be_true
          response.first["ZIP_CODE"].should == 21209
          response.first["UV_INDEX"].should == 3
          response.first["UV_ALERT"].should == 0
        end
      end
    
      context "when the response is empty" do
        before do
          response = mock(Object)
          response.stub!(:body).and_return '[]'
          response.stub!(:code).and_return 200
          HTTParty.should_receive(:get).with("http://iaspub.epa.gov/enviro/efservice/getEnvirofactsUVDAILY/ZIP/21209/json").and_return response
        end

        it "should return an array for a daily zip code request" do
          response = EpaUvIndex::Client.daily_for(:zip => '21209')
          response.is_a?(Array).should be_true
          response.should be_empty
        end
      end
    
      context "when the status code is not 200" do
        before do
          response = mock(Object)
          response.stub!(:code).and_return 406
          response.stub!(:message).and_return "Error Message"
          HTTParty.should_receive(:get).with("http://iaspub.epa.gov/enviro/efservice/getEnvirofactsUVDAILY/ZIP/21209/json").and_return response
        end
      
        it "should raise an exception" do
          lambda { EpaUvIndex::Client.daily_for(:zip => '21209')}.should raise_error "Error Message"
        end
      end
    end

    context "when querying for a daily UV index for a city/state" do
      context "when the response is good" do
        before do
          response = mock(Object)
          response.stub!(:body).and_return '[{"CITY":"BALTIMORE","STATE":"MD","UV_INDEX":4,"UV_ALERT":0}]'
          response.stub!(:code).and_return 200
          HTTParty.should_receive(:get).with("http://iaspub.epa.gov/enviro/efservice/getEnvirofactsUVDAILY/CITY/Baltimore/STATE/md/json").and_return response
        end

        it "should return an array for a daily zip code request" do
          response = EpaUvIndex::Client.daily_for(:city => 'Baltimore', :state => 'md')
          response.is_a?(Array).should be_true
          response.first["CITY"].should == "BALTIMORE"
          response.first["STATE"].should == "MD"
          response.first["UV_INDEX"].should == 4
          response.first["UV_ALERT"].should == 0
        end
      end
    
      context "when the response is empty" do
        before do
          response = mock(Object)
          response.stub!(:body).and_return '[]'
          response.stub!(:code).and_return 200
          HTTParty.should_receive(:get).with("http://iaspub.epa.gov/enviro/efservice/getEnvirofactsUVDAILY/CITY/Baltimore/STATE/md/json").and_return response
        end

        it "should return an array for a daily zip code request" do
          response = EpaUvIndex::Client.daily_for(:city => 'Baltimore', :state => 'md')
          response.is_a?(Array).should be_true
          response.should be_empty
        end
      end
    
      context "when the status code is not 200" do
        before do
          response = mock(Object)
          response.stub!(:code).and_return 406
          response.stub!(:message).and_return "Error Message"
          HTTParty.should_receive(:get).with("http://iaspub.epa.gov/enviro/efservice/getEnvirofactsUVDAILY/CITY/baltimore/STATE/md/json").and_return response
        end
      
        it "should raise an exception" do
          lambda { EpaUvIndex::Client.daily_for(:city => 'baltimore', :state => 'md')}.should raise_error "Error Message"
        end
      end    
    end
  end
  
  describe "#hourly_for" do
    context "when neither a zip nor a city/state are passed as parameters" do
      it "should raise an exception" do
        lambda { EpaUvIndex::Client.hourly_for(:city => 'Baltimore')}.should raise_error "Please provide either a city/state or a zip code."
      end
    end

    context "when querying for an hourly UV index for a zip code" do
      context "when the response is good" do
        before do
          response = mock(Object)
          response.stub!(:body).and_return '[{"ORDER":1,"ZIP":21209,"DATE_TIME":"OCT/09/2012 06 AM","UV_VALUE":0},{"ORDER":2,"ZIP":21209,"DATE_TIME":"OCT/09/2012 07 AM","UV_VALUE":0},{"ORDER":3,"ZIP":21209,"DATE_TIME":"OCT/09/2012 08 AM","UV_VALUE":0},{"ORDER":4,"ZIP":21209,"DATE_TIME":"OCT/09/2012 09 AM","UV_VALUE":0},{"ORDER":5,"ZIP":21209,"DATE_TIME":"OCT/09/2012 10 AM","UV_VALUE":2},{"ORDER":6,"ZIP":21209,"DATE_TIME":"OCT/09/2012 11 AM","UV_VALUE":1},{"ORDER":7,"ZIP":21209,"DATE_TIME":"OCT/09/2012 12 PM","UV_VALUE":2},{"ORDER":8,"ZIP":21209,"DATE_TIME":"OCT/09/2012 01 PM","UV_VALUE":2},{"ORDER":9,"ZIP":21209,"DATE_TIME":"OCT/09/2012 02 PM","UV_VALUE":1},{"ORDER":10,"ZIP":21209,"DATE_TIME":"OCT/09/2012 03 PM","UV_VALUE":1},{"ORDER":11,"ZIP":21209,"DATE_TIME":"OCT/09/2012 04 PM","UV_VALUE":0},{"ORDER":12,"ZIP":21209,"DATE_TIME":"OCT/09/2012 05 PM","UV_VALUE":0},{"ORDER":13,"ZIP":21209,"DATE_TIME":"OCT/09/2012 06 PM","UV_VALUE":0},{"ORDER":14,"ZIP":21209,"DATE_TIME":"OCT/09/2012 07 PM","UV_VALUE":0},{"ORDER":15,"ZIP":21209,"DATE_TIME":"OCT/09/2012 08 PM","UV_VALUE":0},{"ORDER":16,"ZIP":21209,"DATE_TIME":"OCT/09/2012 09 PM","UV_VALUE":0},{"ORDER":17,"ZIP":21209,"DATE_TIME":"OCT/09/2012 10 PM","UV_VALUE":0},{"ORDER":18,"ZIP":21209,"DATE_TIME":"OCT/09/2012 11 PM","UV_VALUE":0},{"ORDER":19,"ZIP":21209,"DATE_TIME":"OCT/09/2012 12 AM","UV_VALUE":0},{"ORDER":20,"ZIP":21209,"DATE_TIME":"OCT/09/2012 01 AM","UV_VALUE":0},{"ORDER":21,"ZIP":21209,"DATE_TIME":"OCT/09/2012 02 AM","UV_VALUE":0}]'
          response.stub!(:code).and_return 200
          HTTParty.should_receive(:get).with("http://iaspub.epa.gov/enviro/efservice/getEnvirofactsUVHOURLY/ZIP/21209/json").and_return response
        end

        it "should return an array for a daily zip code request" do
          response = EpaUvIndex::Client.hourly_for(:zip => '21209')
          response.is_a?(Array).should be_true
          response.size.should == 21
          response.each_with_index do |value, index|
            value["ORDER"].should == index + 1
            value["ZIP"].should == 21209
            value["DATE_TIME"].should =~ /OCT\/09\/2012/
            value["UV_VALUE"].is_a?(Integer).should be_true
          end
        end
      end
    
      context "when the response is empty" do
        before do
          response = mock(Object)
          response.stub!(:body).and_return '[]'
          response.stub!(:code).and_return 200
          HTTParty.should_receive(:get).with("http://iaspub.epa.gov/enviro/efservice/getEnvirofactsUVHOURLY/ZIP/21209/json").and_return response
        end

        it "should return an array for a daily zip code request" do
          response = EpaUvIndex::Client.hourly_for(:zip => '21209')
          response.is_a?(Array).should be_true
          response.should be_empty
        end
      end
    
      context "when the status code is not 200" do
        before do
          response = mock(Object)
          response.stub!(:code).and_return 406
          response.stub!(:message).and_return "Error Message"
          HTTParty.should_receive(:get).with("http://iaspub.epa.gov/enviro/efservice/getEnvirofactsUVHOURLY/ZIP/21209/json").and_return response
        end
      
        it "should raise an exception" do
          lambda { EpaUvIndex::Client.hourly_for(:zip => '21209')}.should raise_error "Error Message"
        end
      end      
    end
    
    context "when query for an hourly UV index for a city/state" do
      context "when the response is good" do
        before do
          response = mock(Object)
          response.stub!(:body).and_return '[{"SEQUENCE":1,"CITY":"BALTIMORE","STATE":"MD","DATE_TIME":"OCT/09/2012 06 AM","UV_VALUE":0},{"SEQUENCE":2,"CITY":"BALTIMORE","STATE":"MD","DATE_TIME":"OCT/09/2012 07 AM","UV_VALUE":0},{"SEQUENCE":3,"CITY":"BALTIMORE","STATE":"MD","DATE_TIME":"OCT/09/2012 08 AM","UV_VALUE":0},{"SEQUENCE":4,"CITY":"BALTIMORE","STATE":"MD","DATE_TIME":"OCT/09/2012 09 AM","UV_VALUE":0},{"SEQUENCE":5,"CITY":"BALTIMORE","STATE":"MD","DATE_TIME":"OCT/09/2012 10 AM","UV_VALUE":1},{"SEQUENCE":6,"CITY":"BALTIMORE","STATE":"MD","DATE_TIME":"OCT/09/2012 11 AM","UV_VALUE":1},{"SEQUENCE":7,"CITY":"BALTIMORE","STATE":"MD","DATE_TIME":"OCT/09/2012 12 PM","UV_VALUE":2},{"SEQUENCE":8,"CITY":"BALTIMORE","STATE":"MD","DATE_TIME":"OCT/09/2012 01 PM","UV_VALUE":2},{"SEQUENCE":9,"CITY":"BALTIMORE","STATE":"MD","DATE_TIME":"OCT/09/2012 02 PM","UV_VALUE":1},{"SEQUENCE":10,"CITY":"BALTIMORE","STATE":"MD","DATE_TIME":"OCT/09/2012 03 PM","UV_VALUE":1},{"SEQUENCE":11,"CITY":"BALTIMORE","STATE":"MD","DATE_TIME":"OCT/09/2012 04 PM","UV_VALUE":0},{"SEQUENCE":12,"CITY":"BALTIMORE","STATE":"MD","DATE_TIME":"OCT/09/2012 05 PM","UV_VALUE":0},{"SEQUENCE":13,"CITY":"BALTIMORE","STATE":"MD","DATE_TIME":"OCT/09/2012 06 PM","UV_VALUE":0},{"SEQUENCE":14,"CITY":"BALTIMORE","STATE":"MD","DATE_TIME":"OCT/09/2012 07 PM","UV_VALUE":0},{"SEQUENCE":15,"CITY":"BALTIMORE","STATE":"MD","DATE_TIME":"OCT/09/2012 08 PM","UV_VALUE":0},{"SEQUENCE":16,"CITY":"BALTIMORE","STATE":"MD","DATE_TIME":"OCT/09/2012 09 PM","UV_VALUE":0},{"SEQUENCE":17,"CITY":"BALTIMORE","STATE":"MD","DATE_TIME":"OCT/09/2012 10 PM","UV_VALUE":0},{"SEQUENCE":18,"CITY":"BALTIMORE","STATE":"MD","DATE_TIME":"OCT/09/2012 11 PM","UV_VALUE":0},{"SEQUENCE":19,"CITY":"BALTIMORE","STATE":"MD","DATE_TIME":"OCT/09/2012 12 AM","UV_VALUE":0},{"SEQUENCE":20,"CITY":"BALTIMORE","STATE":"MD","DATE_TIME":"OCT/09/2012 01 AM","UV_VALUE":0},{"SEQUENCE":21,"CITY":"BALTIMORE","STATE":"MD","DATE_TIME":"OCT/09/2012 02 AM","UV_VALUE":0}]'
          response.stub!(:code).and_return 200
          HTTParty.should_receive(:get).with("http://iaspub.epa.gov/enviro/efservice/getEnvirofactsUVHOURLY/CITY/Baltimore/STATE/md/json").and_return response
        end

        it "should return an array for a daily zip code request" do
          response = EpaUvIndex::Client.hourly_for(:city => 'Baltimore', :state => 'md')
          response.is_a?(Array).should be_true
          response.size.should == 21
          response.each_with_index do |value, index|
            value["SEQUENCE"].should == index + 1
            value["CITY"].should == "BALTIMORE"
            value["STATE"].should == "MD"
            value["DATE_TIME"].should =~ /OCT\/09\/2012/
            value["UV_VALUE"].is_a?(Integer).should be_true
          end
        end
      end
    
      context "when the response is empty" do
        before do
          response = mock(Object)
          response.stub!(:body).and_return '[]'
          response.stub!(:code).and_return 200
          HTTParty.should_receive(:get).with("http://iaspub.epa.gov/enviro/efservice/getEnvirofactsUVHOURLY/CITY/Baltimore/STATE/md/json").and_return response
        end

        it "should return an array for a daily zip code request" do
          response = EpaUvIndex::Client.hourly_for(:city => 'Baltimore', :state => 'md')
          response.is_a?(Array).should be_true
          response.should be_empty
        end
      end
    
      context "when the status code is not 200" do
        before do
          response = mock(Object)
          response.stub!(:code).and_return 406
          response.stub!(:message).and_return "Error Message"
          HTTParty.should_receive(:get).with("http://iaspub.epa.gov/enviro/efservice/getEnvirofactsUVHOURLY/CITY/baltimore/STATE/md/json").and_return response
        end
      
        it "should raise an exception" do
          lambda { EpaUvIndex::Client.hourly_for(:city => 'baltimore', :state => 'md')}.should raise_error "Error Message"
        end
      end      
    end
  end
end