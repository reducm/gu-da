require 'spec_helper'

describe Picture do
  before(:each) do
    @jas = FactoryGirl.create :jas
    @article = FactoryGirl.create :article, user:@jas
    10.times{ FactoryGirl.create :picture, pictureable:@jas }
    @pic = @jas.pictures.first
  end

  context "function" do
    it "after create" do
      @pic.file_name.should_not be_nil
      @pic.file_size.should_not be_nil
      @pic.file_type.should_not be_nil
    end

    it "to_json" do
      result = JSON.parse @pic.to_json
      result.should have_key("has_normal")
    end

    it "get_index" do
      ps =  Picture.get_index({user_id: @jas.id})   
      ps.size.should == 8
      ps =  Picture.get_index({user_id: @jas.id, page:2})   
      ps.size.should == 2
    end
  end
end
