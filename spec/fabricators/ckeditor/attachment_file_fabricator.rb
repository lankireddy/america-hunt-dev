Fabricator(:ckeditor_attachment_file, class_name: 'Ckeditor::AttachmentFile') do
  data { File.new("#{Rails.root}/spec/support/files/4.jpg") }
  assetable_id { Faker::Number.between(1, 100) }
  assetable_type { 'AdminUser' }
  type { 'Ckeditor::AttachmentFile' }
  width { 1500 }
  height { 1000 }
end
