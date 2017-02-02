Fabricator(:ckeditor_picture, class_name: 'Ckeditor::Picture') do
  data { File.new("#{Rails.root}/spec/support/files/4.jpg") }
  assetable_id { Faker::Number.between(1, 100) }
  assetable_type { 'AdminUser' }
  type { 'Ckeditor::Picture' }
  width { 165 }
  height { 189 }
end
