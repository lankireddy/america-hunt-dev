require 'spec_helper'

describe 'Admin User' do
  let!(:admin_user) { Fabricate :admin_user }

  let(:attributes) { [:email, :name, :password, :password_confirmation] }

  before do
    login_admin admin_user
  end

  describe 'admin index' do
    it 'can view a list of Users' do
      admin_users = Fabricate.times(3, :admin_user)
      visit admin_admin_users_path
      admin_users.each do |admin_user|
        expect(page).to have_content(admin_user.email)
      end
    end
  end

  describe 'admin create', js: true do
    let!(:new_admin_user) { Fabricate.build :admin_user }
    let!(:new_title) { 'New Admin User' }

    it 'will create an admin user' do
      visit admin_admin_users_path
      
      find_link(new_title, href: new_admin_admin_user_path).click

      expect(page).to have_content new_title

      attributes.each do |attr|
        fill_in(("admin_user_#{attr.to_s}"), with: new_admin_user.send(attr))
      end
      fill_in 'admin_user_password_confirmation', with: new_admin_user.password

      expect do
        find('input[type="submit"]',  match: :first).click
        expect(page).to have_content(new_admin_user.email)
      end.to change { AdminUser.count }.by (1)
    end

    it 'must enter a email when creating a AdminUser' do
      visit admin_admin_users_path

      find_link(new_title, href: new_admin_admin_user_path).click

      expect(page).to have_content new_title

      (attributes - [:email]).each do |attr|
        fill_in(("admin_user_#{attr.to_s}"), with: new_admin_user.send(attr))
      end
      fill_in 'admin_user_password_confirmation', with: new_admin_user.password

      expect do
        find('input[type="submit"]',  match: :first).click
      end.not_to change { AdminUser.count }
    end

    it 'must enter a name when creating a AdminUser' do
      visit admin_admin_users_path

      find_link(new_title, href: new_admin_admin_user_path).click

      expect(page).to have_content new_title

      (attributes - [:name]).each do |attr|
        fill_in(("admin_user_#{attr.to_s}"), with: new_admin_user.send(attr))
      end

      fill_in 'admin_user_password_confirmation', with: new_admin_user.password

      expect do
        find('input[type="submit"]',  match: :first).click
      end.not_to change { User.count }
    end

    it 'must enter a password when creating a User' do
      visit admin_admin_users_path

      find_link(new_title, href: new_admin_admin_user_path).click

      expect(page).to have_content new_title

      (attributes - [:password]).each do |attr|
        fill_in(("admin_user_#{attr.to_s}"), with: new_admin_user.send(attr))
      end
      fill_in 'admin_user_password_confirmation', with: new_admin_user.password

      expect do
        find('input[type="submit"]',  match: :first).click
      end.not_to change { User.count }
    end
  end

  describe 'admin edit' do
    let!(:admin_user) { Fabricate :admin_user }

    it 'will edit a user' do
      new_user = Fabricate.build :admin_user
      user = Fabricate(:admin_user)
      
      visit edit_admin_admin_user_path(user)

      expect(page).to have_content('Edit Admin User')

      (attributes - [:password] - [:password_confirmation]).each do |attr|
        fill_in(("admin_user_#{attr.to_s}"), with: new_user.send(attr))
      end

      find('input[type="submit"]',  match: :first).click
      
      expect(page).to have_content(new_user.email)
      user.reload

      attributes.each do |attr|
        expect(user.send(attr)).to eq(new_user.send(attr))
      end
    end
  end
  
  it 'can destroy a User' do
    user = Fabricate(:admin_user)

    visit admin_admin_users_path

    expect(page).to have_selector("#admin_user_#{user.id}")
    
    find('.delete_link.member_link', match: :first).click
    
    expect(page).not_to have_selector("#admin_user_#{user.id}")
  end
end