class ContactMessageSerializer < ActiveModel::Serializer
  attributes :id, :email, :subject, :body
end
