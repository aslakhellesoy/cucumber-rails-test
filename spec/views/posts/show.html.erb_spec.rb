require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/posts/show.html.erb" do
  include PostsHelper
  
  before(:each) do
    assigns[:post] = @post = stub_model(Post,
      :title => "value for title",
      :body => "value for body",
      :published => false
    )
  end

  it "should render attributes in <p>" do
    render "/posts/show.html.erb"
    response.should have_text(/value\ for\ title/)
    response.should have_text(/value\ for\ body/)
    response.should have_text(/als/)
  end
end

