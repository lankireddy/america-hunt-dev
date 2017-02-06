Fabricator(:ckeditor_attachment_file, class_name: 'Ckeditor::AttachmentFile') do
  data { File.new("#{Rails.root}/spec/support/files/4.jpg") }
  assetable_id { (Fabricate :admin_user).id }
  assetable_type { 'AdminUser' }
  type { 'Ckeditor::AttachmentFile' }
  width { 1500 }
  height { 1000 }
end
