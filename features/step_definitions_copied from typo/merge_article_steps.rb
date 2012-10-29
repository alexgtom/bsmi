When /^I merge article (\d+) with article (\d+)$/ do |id1, id2|
  visit url_for(:controller => "admin/content", :action => 'edit', :id => id1)
  fill_in("#merge_with", :with => id2)
  click_button "Merge"
end

Then /^article (\d+) should have content from both articles$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then /^the author for article (\d+) should be the author of one of: "(.*?)"$/ do |arg1, arg2|
  pending # express the regexp above with the code you wish you had
end

Then /^the ([^\s]+) for article (\d+) should include: (.*)$/ do 
  |field_name, article_id, values|
  values = parse_list(values)

  with_article_field(article_id, field_name) do |field|
    values.each do |val|
      field.should include val
    end
  end
end

Then /^the ([^\s]+) for article (\d+) should be one of: (.*)$/ do 
  |field_name, article_id, values|
  values = parse_list(values)
  with_article_field(article_id, field_name) do |field|

    values.should include field
  end
end

Then /^the comments for article (\d+) should include the comments from articles: (\d+), (\d+)$/ do |arg1, arg2, arg3|
  pending # express the regexp above with the code you wish you had
end

Given /^I am not an administrator$/ do
  me = Factory.create(:user)
  login(me.login, 'top-secret')
end


def login(user, password)
  visit '/accounts/login'
  fill_in 'user_login', :with => user
  fill_in 'user_password', :with => password

  click_button 'Login'
  if page.respond_to? :should
    page.should have_content('Login successful')
  else
    assert page.has_content?('Login successful')
  end
end


def with_article_field(article_id, field_name,  &block)
  article = Article.find(article_id.to_i)
  field = article.send(field_name.to_sym)
  yield field
end


def parse_list(values)
  values.scan(/"(.*?)"/).flatten
end
