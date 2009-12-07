Given /I have gone to the new lorry page/ do
  visit "/lorries/new"
  true.should be_true
end

Given /^the following lorries:$/ do |lorries|
  Lorry.create!(lorries.hashes)
  Lorry.should have(lorries.hashes.length).records
end

When /^I delete the (\d+)(?:st|nd|rd|th) lorry$/ do |pos|
  visit lorries_url
  within("table > tr:nth-child(#{pos.to_i+1})") do
    click_link "Destroy"
  end
end

When /^I delete the 4th lorry and deal with the expected error$/ do
  begin
    When %{I delete the 4th lorry}
    raise "This should have raised an error"
  rescue Webrat::PageLoadError => expected
  end
end

Then /^I should see the following lorries:$/ do |expected_lorries_table|
  expected_lorries_table.map_headers!(/name/ => 'Name', /colour/ => 'Colour')
  expected_lorries_table.diff!(tableish('table tr', 'td,th'))
end

Then /^I should see the following lorries in a definition list:$/ do |expected_lorries_table|
  expected_lorries_table.diff!(tableish('dl#lorry_dl dt', lambda{|dt| [dt, dt.next.next]}))
end

Then /^I should see the following lorries in an ordered list:$/ do |expected_lorries_table|
  expected_lorries_table.diff!(tableish('ol#lorry_ol li', lambda{|li| [li]}))
end

Given /^I have not created any lorries in this scenario$/ do
  # no-op
end

Given /^the previous scenarios have$/ do
  # no-op
end

Given /I have 45 pink lorries/ do
  raise "This is failing"
end

Then /^there should be (.*) lorries$/ do |n|
  Lorry.count.should == n.to_i
end
