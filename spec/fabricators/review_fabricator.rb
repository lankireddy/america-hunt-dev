Fabricator(:review) do
  star_rating  '9.5'
  body         'MyText'
  submitter(fabricator: :user)
  status       'approved'
  location
end
