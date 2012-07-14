#encoding: utf-8
require 'spec_helper'
describe User do
  let!(:user) {Factory :jas}
  let(:params) { {nickname:'jas',password:'aaaaaa' } }

  describe "test check function" do
    it "check success" do
      u = User.check(params)
      u.id.should_not be_nil
      u.nickname.should == 'jas'
    end

    it "check error" do
      params[:password] ='ffffff'
      u = User.check(params)
      u.errors[:password].should == ['密码错误']
      params[:nickname] = 'chacha'
      u = User.check(params)
      u.errors[:nickname].should == ['没有这个用户']
    end
  end
end
