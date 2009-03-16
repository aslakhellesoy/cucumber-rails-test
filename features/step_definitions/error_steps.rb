When /I visit a nonexistent page/ do
  begin
    visit "/does/not/exist"
  rescue => e
    @message = e.message
  end
end

When /I visit a failing page/ do
  begin
    visit "/failing"
  rescue => e
    @message = e.message
  end
end

Then /^the Ruby error message should match '(.*)'$/ do |message|
  @message.should =~ Regexp.new(message)
end
