Fabricator(:review) do
  star_rating  '9.5'
  body         'MyText'
  submitter(fabricator: :user)
  status       'pending'
  location
end
