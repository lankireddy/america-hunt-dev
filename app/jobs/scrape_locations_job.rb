class ScrapeLocationsJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    a = Mechanize.new
    a.get('https://portal.travelier.com/login') do |page|

      # Submit the login form
      my_page = page.form_with(:action => '/sessions') do |f|
        f['login_dto[email]']  = 'jessica@myusatlas.com'
        f['login_dto[password]'] = '1jesusaves'
      end.click_button
      #binding.pry
      begin
        list = a.click(my_page.link_with(:text => /View All/))
      rescue => e
        binding.pry
      end


      #binding.pry
      my_page.links.each do |link|
        text = link.text.strip
        next unless text.length > 0
        puts text
      end
    end
  end
end
