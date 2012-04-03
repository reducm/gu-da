require 'spec_helper'
describe User do
  before() do
    @user = Factory.build(:user)
    @user.save
    @tag = Factory.build(:tag)
    @as = []
    10.times do |i|
      @as << Factory.build(:article, {title:"fuck #{i}times", content:"thank you", user:@user})
    end
  end

  context "test CRUD" do 
    it "create" do
#      u = Factory.create :user, {name:'stupid', password_confirm:'password', password:'password', email:'stupid@haha.com'}
      u = User.create(name:'stupid', password_confirm:'password', password:'password', email:'stupid@haha.com')
      u.new_record?.should be_false
      u.save.should be_true
      u.id.blank?.should be_false
    end

    it "read" do
      @user.reload
      @user.name.blank?.should be_false
      @user.email.blank?.should be_false
      @user.password.blank?.should be_false
    end

    it "update" do
      @user.update_attributes(name:'jas1',password:'123456',email:'guda@gmail.com').should be_true
      @user.reload
      @user.name.should == 'jas1'
      @user.email.should == 'guda@gmail.com'
      @user.password.should_not == '11' 
    end

    it "delete" do
      id = @user.id
      @user.destroy
      expect {User.find(id)}.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  context "test validate" do
    it "validates_presence_of name and email and password" do
      u = User.new(birthday:"2011-12-15")
      u.save.should be_false
      u.name = "fuck"
      u.password = "shit"
      u.password_confirm = 'shit'
      u.email = "shit@shit.com"
      u.save.should be_true
    end
  end

  context "test association " do
    it "has many articles" do
      @as.each do |a|
        a.save.should be_true
        @user.articles << a
        @user.save.should be_true
      end
      @user.articles.size.should == 10
    end
  end
end
