require 'spec_helper'

describe Tag do
  before do
    @tag = Factory.build(:tag, {name:"test"})
    @tag1 = Factory.build(:tag, {name:"test1"})
    @user = Factory.create(:user, {name:"test",password:2,password_confirm:2,email:"rec@rails.com"})
    @a1 = Factory.create(:article, {title:"a1",content:"a2", user:@user })
    @a2 = Factory.create(:article, {title:"a2",content:"a2"})
  end

  context 'db' do
    it "test load" do
      @tag.name.should == "test"
      @tag1.name.should == "test1"
    end

    it "associate with articles" do
      @a1.title.should == "a1"
      @a2.title.should == "a2"
#      ArticleTagship.create(tag:@tag,article:@a1)
#      ArticleTagship.create(tag:@tag1,article:@a1)
#      ArticleTagship.create(tag:@tag,article:@a2)
#      ArticleTagship.create(tag:@tag1,article:@a2)
      Factory.create(:ats, {tag:@tag, article:@a1})
      Factory.create(:ats, {tag:@tag1, article:@a1})
      Factory.create(:ats, {tag:@tag, article:@a2})
      Factory.create(:ats, {tag:@tag1, article:@a2})
      @tag.reload
      @tag1.reload
      @tag.articles.size.should == 2
      @tag1.articles.size.should == 2
      @atemp = @tag.articles.find_by_title("a1")
      p @atemp.class
      @atemp.title.should == @a1.title
    end

  end
end
