Then /^page must successfully load$/ do
  page.status_code.should == 200
end
