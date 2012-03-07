require 'spec_helper'

describe "users/index.html.erb" do
=begin
  before(:each) do
    assign(:users, [
      stub_model(User,
        :name => "Name",
        :email => "Email",
        :password => "",
        :head => "Head",
        :description => "Description",
        :habit => "Habit"
      ),
      stub_model(User,
        :name => "Name",
        :email => "Email",
        :password => "",
        :head => "Head",
        :description => "Description",
        :habit => "Habit"
      )
    ])
  end

  it "renders a list of users" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Head".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Description".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Habit".to_s, :count => 2
  end
=end
end
