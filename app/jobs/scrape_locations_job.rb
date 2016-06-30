class ScrapeLocationsJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    a = Mechanize.new
    TravelierSession.new.login(a)
    begin
      domain = 'https://portal.travelier.com'
      ajax_headers = { 'X-Requested-With' => 'XMLHttpRequest', 'Accept' => 'application/json, text/javascript, */*'}
      next_page_link = '/admin/locations'
      direct_import_attributes = %w[name website contact_page phone email address_1 address_2 city zip opening_date featured follow_up]

      loop do
        puts "getting #{next_page_link}"
        a.get(domain + next_page_link,[],nil,ajax_headers) do |js|
          doc = js_to_doc(js)
          next_page_link = doc.at_css('li.next_page a')['href']
          location_ids = location_ids(doc)
          Location.where(travelier_id: location_ids.map(&:to_i)).delete_all
          location_ids.each do |id|
            location = Location.new
            location.travelier_id = id
            #binding.pry
            a.get(domain + "/admin/locations/#{id}/edit") do |page|
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
              location.save
            end
          end
          #binding.pry
        end
      end
    rescue => e
      binding.pry
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

  def location_ids(doc)
    doc.css('tr').map { |tr| (tr['id']).try(:slice, 9..-1) }.compact
  end

  def js_to_doc(page)
    raw_js = page.body
    no_wrap = raw_js[27..-2]
    slashes_removed = no_wrap.gsub('\\', '')
    Nokogiri::HTML(slashes_removed)
  end
end
