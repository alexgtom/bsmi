
Given /^the following posts exist:$/ do |table|
  table.hashes.each do |row| 
    Article.create(row)
  end
  
end

Given /^the following comments have been made:$/ do |table|
  table.hashes.each do |row| 
    row["article_id"] = row["article_id"].to_i    
    Comment.create(row)
  end
  
end
