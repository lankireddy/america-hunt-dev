require 'spec_helper'

describe ApplicationHelper do
  let!(:pages) { [{ title: 'About', path: page_path('about') }, { title: 'Press & Media', path: page_path('press-&-media') }, { title: 'FAQ', path: page_path('faq') }, { title: 'Terms of Service', path: page_path('terms-of-service') }, { title: 'Privacy Policy', path: page_path('privacy-policy') }] }
  let!(:name) { 'About Us' }

  describe '#li_link_to_active_class' do
    it 'returns the li' do
      expect(helper.li_link_to_active_class 'Send Us News', '/send-us-news').to eq "<li>#{link_to 'Send Us News', '/send-us-news'}</li>"
    end
  end

  describe '#li_dropdown_link_to_active_class' do
    it 'returns the dropdown' do
      dropdown_text =   '<li class="dropdown">
                          <a class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false" href="#">About Us <span class="caret" /></a>
                          <ul class="dropdown-menu">
                            <li><a href="/about">About</a></li>
                            <li><a href="/press-&amp;-media">Press &amp; Media</a></li>
                            <li><a href="/faq">FAQ</a></li>
                            <li><a href="/terms-of-service">Terms of Service</a></li>
                            <li><a href="/privacy-policy">Privacy Policy</a></li>
                          </ul>
                        </li>'.squish.strip.gsub(/> </, '><')
      expect(helper.li_dropdown_link_to_active_class name, pages).to eq dropdown_text.squish.strip.gsub(/> </, '><')
    end
  end

  describe '#ul_dropdown' do
    it 'returns the ul with a li for each page' do
      ul_text = '<ul class="dropdown-menu">
                  <li><a href="/about">About</a></li>
                  <li><a href="/press-&amp;-media">Press &amp; Media</a></li>
                  <li><a href="/faq">FAQ</a></li>
                  <li><a href="/terms-of-service">Terms of Service</a></li>
                  <li><a href="/privacy-policy">Privacy Policy</a></li>
                </ul>'.squish.strip.gsub(/> </, '><')
      expect(helper.ul_dropdown pages).to eq ul_text.squish.strip.gsub(/> </, '><')
    end
  end

  describe '#a_dropdown' do
    it 'returns the link for the dropdown itself' do
      a_text = '<a class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false" href="#">About Us <span class="caret" /></a>'.squish.strip.gsub(/> </, '><')
      expect(helper.a_dropdown name).to eq a_text.squish.strip.gsub(/> </, '><')
    end
  end
end
