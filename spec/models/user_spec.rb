#encoding: utf-8
require 'spec_helper'
describe User do
  let!(:user) {Factory :user}
  let(:params) { {name:'jas',password:'aaaaaa' } }

  describe "test check function" do
    it "check success" do
      u = User.check(params)
      u.id.should_not be_nil
      u.name.should == 'jas'
    end

    it "check error" do
      params[:password] ='ffffff'
      u = User.check(params)
      u.errors[:password].should == ['密码错误']
      params[:name] = 'chacha'
      u = User.check(params)
      u.errors[:name].should == ['没有这个用户']
    end
  end
end
