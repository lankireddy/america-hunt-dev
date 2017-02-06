Fabricator(:ckeditor_picture, class_name: 'Ckeditor::Picture') do
  data { File.new("#{Rails.root}/spec/support/files/4.jpg") }
  assetable_id { (Fabricate :admin_user).id }
  assetable_type { 'AdminUser' }
  type { 'Ckeditor::Picture' }
  width { 165 }
  height { 189 }
end
