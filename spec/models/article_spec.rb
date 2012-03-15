require 'spec_helper'

describe Article do
  before(:all) do
    @article = Factory.build(:article) 
  end

  context "model CURD" do
    it "test save" do
      @article.save.should be_true
      @article.new_record?.should be_false
    end
  end
end
