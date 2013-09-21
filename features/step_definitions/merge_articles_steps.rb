Given /^two similar articles are published$/ do
  2.times do |i|
  	@admin.articles.create({title: "A new article",
  		                    body: "An article body #{i}",
  		                    permalink: 'a-big-article',
  		                    published: true})

  end
  @admin.articles.count.should >= 2
end

When /^I follow to edit page of first article$/ do
  @articles = @admin.articles.where(title: "A new article")
  visit "/admin/content/edit/#{@articles.first.id}"
end

Then /^I should see button "(.*?)"$/ do |name|
  page.should have_button("#{name}")
end

When /^I input second article id in Article ID field$/ do
  fill_in "Article ID", with: @articles.second.id
end

Then /^I should be redirected to articles page$/ do
  page.current_path.should == "/admin/content"
end

Given /^I am logged in as non\-admin$/ do
  @user = User.create!({:login => 'nonadmin',
                :password => 'aaaaaaaa',
                :email => 'john@snow.com',
                :profile_id => 2,
                :name => 'nonadmin',
                :state => 'active'})
  visit '/accounts/login'
  fill_in 'user_login', :with => 'nonadmin'
  fill_in 'user_password', :with => 'aaaaaaaa'
  click_button 'Login'
  if page.respond_to? :should
    page.should have_content('Login successful')
  else
    assert page.has_content?('Login successful')
  end 
end

When /^I post to merge path$/ do
  @first = Article.first
  @second = Article.last
  post merge_path(@first.id) , merge_id: @second.id
end

Then /^I should be redirected to admin panel$/ do
  page.current_path.should == "/admin/content"
end

Then /^articles should be merged$/ do
  first_id = @articles.first.id
  @merged_article =  Article.find(first_id)
  @articles.each do |article|
    @merged_article.body.should include(article.body)
  end
end