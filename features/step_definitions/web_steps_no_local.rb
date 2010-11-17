# encoding: utf-8

require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))

def assert_response_status(http_status)
  page.status_code.should == http_status.to_i
end

Then /^I should get a "(\d+)" response$/ do |http_status|
  assert_response_status(http_status)
end

Så /^(?:|skal )jeg få "(\d+)" som respons$/ do |http_status|
  Then %{I should get a "#{http_status}" response}
end

Gitt /^at jeg går til (.*)$/ do |page_name|
  Given %{I go to #{page_name}}
end

Gitt /^(?:|at )jeg står på (.*)$/ do |page_name|
  Given %{I am on #{page_name}}
end

Så /^(?:|skal )feltet "([^"]*)" (?:|skal )ikke inneholde "([^"]*)"$/ do |field, value|
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

Then /^I debug$/ do
  debugger
  0 # necesary, else breakpoint will loose context
end

Så /^debugger jeg$/ do
  Then %{I debug}
end

Så /^skal feltet "([^"]*)" være tomt$/ do |field|
  field = find_field(field)
  field_value = (field.tag_name == 'textarea') ? field.text : field.value
  if field_value.respond_to? :should
    field_value.should == ''
  else
    assert_blank field_value
  end
end
