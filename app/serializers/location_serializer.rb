class LocationSerializer < ActiveModel::Serializer
  attributes :id, :travelier_id, :name, :website, :contact_page, :phone, :email, :address_1, :address_2, :city, :zip, :lat, :long, :opening_date, :featured, :follow_up, :description
end
