#encoding: utf-8
require 'spec_helper'
describe User do
  let!(:user) {FactoryGirl.create :jas}
  let(:params) { {nickname:'jas',password:'aaaaaa', email:'jas@gmail.com'} }
  let(:update_params) { {nickname:'jas1',password:'aaaaaa', email:'jas@gmail.com',password_new:'dddddd',password_confirm:'dddddd'} }

  context "function" do
    it "name" do
      user.name.should == user.nickname   
    end

    it "check" do
      u = User.check(params)
      u.id.should_not be_nil
      u.nickname.should == 'jas'
    end
    
    it "check fail" do
      params[:password] = 'xxxx'
      u = User.check(params)
      u.new_record?.should == true
      u.jerrors.should_not be_nil
    end

    it "updates function with new password" do
      user.nickname.should == 'jas' 
      old_password = user.password
      u = User.updates(update_params, user.id)
      u.valid?.should be_true
      u.nickname.should == 'jas1'
      u.password.should_not == old_password
      user.reload
      u.should == user
    end

    it "updates function with no password" do
      update_params[:password] = ""
      update_params[:password_new] = ""
      update_params[:password_confirm] = ""

      old_password = user.password
      u = User.updates(update_params, user.id)
      u.valid?.should be_true
      u.nickname.should == 'jas1'

      update_params.delete_if{|k,v| k.to_s =~ /password/}
      update_params[:nickname] = 'jas2'
      old_password = user.password
      u = User.updates(update_params, user.id)
      u.valid?.should be_true
      u.nickname.should == 'jas2'
    end


    it "updates function with different password" do
      update_params[:password_new] ='fuckfuck'
      update_params[:password_confirm] ='stupid'
      old_password = user.password
      u = User.updates(update_params, user.id)
      u.errors.any?.should be_true
      u.errors[:password_new].should == ['两次输入密码不同']
    end

    it "updates function with wrong password" do
      update_params[:password] ='fuckfuck'
      old_password = user.password
      u = User.updates(update_params, user.id)
      u.errors.any?.should be_true
      u.errors[:password].should == ['旧密码错误']
    end

    it "updates function with length wrong password" do
      update_params[:password_new] ='xxx'
      update_params[:password_confirm] ='xxx'
      old_password = user.password
      u = User.updates(update_params, user.id)
      u.errors.any?.should be_true
      u.errors[:password_new].should == ['新密码长度要在6-20之间']
    end

    it "get_user" do
      params[:user_id] = user.id
      User.get_user(params).should_not be_nil
      params[:user_id] = 'jas'
      User.get_user(params).should_not be_nil
    end
  end

  context "integrate setting" do
    it "has setting after creat" do
      u = FactoryGirl.create(:user)
      u.setting.new_record?.should == false
    end

    it "head" do
      u = FactoryGirl.create(:user)
      u.setting.new_record?.should == false
      u.head.should be_nil
      p = Picture.new(pictureable: u.setting, file:File.open("#{Rails.root}/app/assets/images/rails.png"))
      p.save
      u.setting.reload
      u.setting.picture.should == p
      u.head.should == p
    end
  end
end
