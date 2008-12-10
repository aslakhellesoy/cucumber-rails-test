Given /I am on the new post page/ do
  visit "/posts/new"
end

Given /there are (\d+) posts/ do |n|
  Post.transaction do
    Post.destroy_all
    n.to_i.times do |n|
      Post.create! :name => "Post #{n}"
    end
  end
end

When /I delete the first post/ do
  visit posts_url
  click_link "Destroy"
end

Then /there should be (\d+) posts left/ do |n|
  Post.count.should == n.to_i
  response.should have_tag("table tr", n.to_i + 1) # There is a header row too
end
