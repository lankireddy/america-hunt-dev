describe BlogCategoryPost do
  it { is_expected.to belong_to :blog_category }
  it { is_expected.to belong_to :post }
end
