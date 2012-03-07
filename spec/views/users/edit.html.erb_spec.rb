require 'spec_helper'

describe "users/edit.html.erb" do
=begin
  before(:each) do
    @user = assign(:user, stub_model(User,
      :name => "MyString",
      :email => "MyString",
      :password => "",
      :head => "MyString",
      :description => "MyString",
      :habit => "MyString"
    ))
  end

  it "renders the edit user form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => users_path(@user), :method => "post" do
      assert_select "input#user_name", :name => "user[name]"
      assert_select "input#user_email", :name => "user[email]"
      assert_select "input#user_password", :name => "user[password]"
      assert_select "input#user_head", :name => "user[head]"
      assert_select "input#user_description", :name => "user[description]"
      assert_select "input#user_habit", :name => "user[habit]"
    end
  end
=end
end
