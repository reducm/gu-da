require 'spec_helper'
describe Notification do
  before(:each) do
    @jas = FactoryGirl.create(:jas) 
    @user = FactoryGirl.create(:user)
    @article = FactoryGirl.create(:article, user:@jas)
  end

  #文章有新回复的时候通知作者
  it 'test notify author' do 
    @comment = FactoryGirl.create(:comment, :user=>@user,:article=>@article )
    ns = Notification.get_all(@jas.id)
    ns.size.should > 0
  end

  #有@某注册用户的回复时候,会通知用户，主要测试notify_reply方法
  it 'test notify reply' do
    @comment = FactoryGirl.create(:comment, :user=>@jas,:article=>@article,content:"@#{@user.name} hahahahahahaha" )
    ns = Notification.get_all(@user.id)
    ns.size.should > 0
  end
end
