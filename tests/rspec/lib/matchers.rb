# Include these into your rspec for basic testing

# This is needed for rss feed parsing
require 'rss'

RSpec::Matchers::define :have_title do |text|
  match do |page|
    Capybara.string(page.body).has_selector?('title', text: text)
  end
end

RSpec::Matchers::define :have_css do
  match do |page|
    page.body.include? ".css" or page.body.include? "<style>"
  end
end

RSpec::Matchers::define :have_js do
  match do |page|
    page.body.include? ".js" or page.body.include? "<script>"
  end
end

RSpec::Matchers::define :have_status_of do |array|
  match do |page|
    array.include? page.status_code
  end
end

RSpec::Matchers::define :have_id do |id|
  match do |page|
    page.body.include? id
  end
end

# Custom matcher to check if rss feed is valid and has link
RSpec::Matchers::define :have_rss_link do |link|
  match do |page|
    feed =  RSS::Parser.parse(page.body)
    feed.channel.link.include? link
  end
end
