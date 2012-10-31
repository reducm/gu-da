#encoding: utf-8
require 'spec_helper'
describe User do
  let!(:user) {FactoryGirl.create :jas}
  let(:params) { {nickname:'jas',password:'aaaaaa', email:'jas@gmail.com'} }

  context "function" do
    it "name" do
      user.name.should == user.nickname   
    end
    
    
  end

  context "test check function" do
    it "check success" do
      u = User.check(params)
      u.id.should_not be_nil
      u.nickname.should == 'jas'
    end
  end
end
