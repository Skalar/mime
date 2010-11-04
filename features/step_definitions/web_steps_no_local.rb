# encoding: utf-8

require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))

Gitt /^(?:|at )jeg står på (.*)$/ do |page_name|
  Given %{I am on #{page_name}}
end

Så /^(?:|skal )feltet "([^"]*)" ikke (?:|skal )inneholde "([^"]*)"$/ do |field, value|
  Then %{the "#{field}" field should not contain "#{value}"}
end

Then /^"([^\"]*)" should be visible$/ do |selector|
  assert_not_nil page.has_css?(selector, :visible => true)
end

Then /^"([^\"]*)" should not be visible$/ do |selector|
  page.has_css?(selector, :visible => true).should be_false
end

Så /^(?:skal )"([^"]*)" være synlig$/ do |selector|
  Then %{"#{selector}" should be visible}
end

Så /^(?:skal )ikke "([^"]*)" være synlig$/ do |selector|
  Then %{"#{selector}" should not be visible}
end