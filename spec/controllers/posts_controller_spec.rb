require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PostsController do

  def mock_post(stubs={})
    @mock_post ||= mock_model(Post, stubs)
  end
  
  describe "responding to GET index" do

    it "should expose all posts as @posts" do
      Post.should_receive(:find).with(:all).and_return([mock_post])
      get :index
      assigns[:posts].should == [mock_post]
    end

    describe "with mime type of xml" do
  
      it "should render all posts as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        Post.should_receive(:find).with(:all).and_return(posts = mock("Array of Posts"))
        posts.should_receive(:to_xml).and_return("generated XML")
        get :index
        response.body.should == "generated XML"
      end
    
    end

  end

  describe "responding to GET show" do

    it "should expose the requested post as @post" do
      Post.should_receive(:find).with("37").and_return(mock_post)
      get :show, :id => "37"
      assigns[:post].should equal(mock_post)
    end
    
    describe "with mime type of xml" do

      it "should render the requested post as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        Post.should_receive(:find).with("37").and_return(mock_post)
        mock_post.should_receive(:to_xml).and_return("generated XML")
        get :show, :id => "37"
        response.body.should == "generated XML"
      end

    end
    
  end

  describe "responding to GET new" do
  
    it "should expose a new post as @post" do
      Post.should_receive(:new).and_return(mock_post)
      get :new
      assigns[:post].should equal(mock_post)
    end

  end

  describe "responding to GET edit" do
  
    it "should expose the requested post as @post" do
      Post.should_receive(:find).with("37").and_return(mock_post)
      get :edit, :id => "37"
      assigns[:post].should equal(mock_post)
    end

  end

  describe "responding to POST create" do

    describe "with valid params" do
      
      it "should expose a newly created post as @post" do
        Post.should_receive(:new).with({'these' => 'params'}).and_return(mock_post(:save => true))
        post :create, :post => {:these => 'params'}
        assigns(:post).should equal(mock_post)
      end

      it "should redirect to the created post" do
        Post.stub!(:new).and_return(mock_post(:save => true))
        post :create, :post => {}
        response.should redirect_to(post_url(mock_post))
      end
      
    end
    
    describe "with invalid params" do

      it "should expose a newly created but unsaved post as @post" do
        Post.stub!(:new).with({'these' => 'params'}).and_return(mock_post(:save => false))
        post :create, :post => {:these => 'params'}
        assigns(:post).should equal(mock_post)
      end

      it "should re-render the 'new' template" do
        Post.stub!(:new).and_return(mock_post(:save => false))
        post :create, :post => {}
        response.should render_template('new')
      end
      
    end
    
  end

  describe "responding to PUT udpate" do

    describe "with valid params" do

      it "should update the requested post" do
        Post.should_receive(:find).with("37").and_return(mock_post)
        mock_post.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :post => {:these => 'params'}
      end

      it "should expose the requested post as @post" do
        Post.stub!(:find).and_return(mock_post(:update_attributes => true))
        put :update, :id => "1"
        assigns(:post).should equal(mock_post)
      end

      it "should redirect to the post" do
        Post.stub!(:find).and_return(mock_post(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(post_url(mock_post))
      end

    end
    
    describe "with invalid params" do

      it "should update the requested post" do
        Post.should_receive(:find).with("37").and_return(mock_post)
        mock_post.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :post => {:these => 'params'}
      end

      it "should expose the post as @post" do
        Post.stub!(:find).and_return(mock_post(:update_attributes => false))
        put :update, :id => "1"
        assigns(:post).should equal(mock_post)
      end

      it "should re-render the 'edit' template" do
        Post.stub!(:find).and_return(mock_post(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end

    end

  end

  describe "responding to DELETE destroy" do

    it "should destroy the requested post" do
      Post.should_receive(:find).with("37").and_return(mock_post)
      mock_post.should_receive(:destroy)
      delete :destroy, :id => "37"
    end
  
    it "should redirect to the posts list" do
      Post.stub!(:find).and_return(mock_post(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(posts_url)
    end

  end

end
