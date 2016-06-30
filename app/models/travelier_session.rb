class TravelierSession
  def login(a)
    a.get('https://portal.travelier.com/login') do |page|

      # Submit the login form
      page.form_with(:action => '/sessions') do |f|
        f['login_dto[email]'] = 'jessica@myusatlas.com'
        f['login_dto[password]'] = '1jesusaves'
      end.click_button
    end
  end
end