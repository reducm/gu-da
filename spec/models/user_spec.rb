require 'spec_helper'
describe User do
  before(:all) do
    @user = User.new(name:'test',password:1,email:'fuck')
    @tag = Tag.new(name:"fuck")
    @as = []
    10.times do |i|
      @as << Article.new(title:"fuck #{i}times",content:"really? i think you fuck #{i*Random.rand(50)}times")
    end
#    @user = User.find_by_name('test')
#    @tag = Tag.find_by_name('fuck')
  end
  
  context "when initialize" do 
    it "test the 'before' db insert" do
      @user.name.should == "test"
      (@user.tags << @tag).should be_true
      @user.tags[0].name.should == "fuck"
    end
    
    it "validates_presence_of name and email and password" do
      u = User.new(birthday:"2011-12-15")
      u.save.should be_false
      u.name = "fuck"
      u.password = "shit"
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
