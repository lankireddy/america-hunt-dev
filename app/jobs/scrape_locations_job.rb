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
=begin
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
=end
    end
    begin
      domain = 'https://portal.travelier.com'
      ajax_headers = { 'X-Requested-With' => 'XMLHttpRequest', 'Accept' => 'application/json, text/javascript, */*'}
      next_page_link = '/admin/locations'
      loop do
        puts "getting #{next_page_link}"
        a.get(domain + next_page_link,[],nil,ajax_headers) do |js|
          doc = js_to_doc(js)
          next_page_link = doc.at_css('li.next_page a')['href']
          location_ids = location_ids(doc)
          location_ids.each do |id|
            puts id
          end
          #binding.pry
        end
      end
    rescue => e
      #binding.pry
    end

  end

  def location_ids(doc)
    doc.css('tr').map { |tr| (tr['id']).try(:slice, 9..-1) }
  end

  def js_to_doc(page)
    raw_js = page.body
    no_wrap = raw_js[27..-2]
    slashes_removed = no_wrap.gsub('\\', '')
    Nokogiri::HTML(slashes_removed)
  end
end
