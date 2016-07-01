class ScrapeLocationsJob < ActiveJob::Base
  queue_as :default
  DOMAIN = 'https://portal.travelier.com'

  def direct_import_attributes
    %w[name website contact_page phone email address_1 address_2 city zip opening_date featured follow_up]
  end
  def perform(*args)
    a = Mechanize.new
    TravelierSession.new.login(a)
    begin
      ajax_headers = { 'X-Requested-With' => 'XMLHttpRequest', 'Accept' => 'application/json, text/javascript, */*'}
      next_page_link = '/admin/locations'

      loop do
        puts "getting #{next_page_link}"
        a.get(DOMAIN + next_page_link,[],nil,ajax_headers) do |js|
          doc = js_to_doc(js)
          next_page_link = doc.at_css('li.next_page a')['href']
          location_rows = location_rows(doc)
          build_locations(a, location_rows)
          #binding.pry
        end
      end
    rescue => e
      binding.pry
    end

  end

  def build_locations(a, location_rows)
    Location.where(travelier_id: location_rows.map { |l| l[0].to_i }).delete_all
    location_rows.each do |row|
      location = Location.new
      location.travelier_id = row[0]
      setup_author(location, row[1])
      location.status = row[2].downcase
      set_details(a, location)
      location.save
    end
  end

  def setup_author(location, author_name)
    location.author = AdminUser.find_or_initialize_by(name: author_name)
    if (location.author.new_record?)
      location.author.email = "lee.dykes+fake-#{author_name.gsub(/\s+/, '')}@metova.com"
      location.author.password = 'ran1234dom!ran1234dom!'
      location.author.password_confirmation = 'ran1234dom!ran1234dom!'
    end
  end

  def set_details(mechanize, location)
    mechanize.get(DOMAIN + "/admin/locations/#{location.travelier_id}/edit") do |page|
      direct_import_attributes.each do |param|
        location[param.to_sym] = get_value(page, param)
      end

      location.lat = BigDecimal(get_value(page, 'lat'))
      location.long = BigDecimal(get_value(page, 'lng'))
      location.description = page.search('#location_description')[0].content
      location.child_status = get_radio('child_status', page)
      location.handicap_status = get_radio('handicap_status', page)
      location.pet_status = get_radio('pet_status', page)
      location.state = page.search('#location_state option[selected]')[0]['value']
      travelier_category_ids = page.search('.sortable-categories input[id*="category_id"]').map { |cat| cat['value'] }
      #binding.pry
      location.category_ids = Category.where(travelier_id: travelier_category_ids).ids
      location.travelier_image_paths = page.search('.location-images-containers img').map{|img| img['src']}.join(';')
      binding.pry if location.travelier_image_paths.present?
    end
  end

  def get_radio(name, page)
    child_status_radio = page.search("input[name=\"location[#{name}]\"][checked=\"checked\"]")
    radio_value = child_status_radio[0]['value'] if child_status_radio.present?
    radio_value
  end



  def get_value(page, param)
    page.search("#location_#{param}")[0]['value']
  end

  def location_rows(doc)
    doc.css('tr[id]').map { |tr| [(tr['id']).try(:slice, 9..-1),tr.css('td')[2].text,tr.css('td')[3].text] }
  end

  def js_to_doc(page)
    raw_js = page.body
    no_wrap = raw_js[27..-2]
    slashes_removed = no_wrap.gsub('\\', '')
    Nokogiri::HTML(slashes_removed)
  end
end
