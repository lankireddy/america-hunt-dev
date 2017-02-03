# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = 'https://americahunt.com/'

# Comment these lines for local testing
SitemapGenerator::Sitemap.public_path = 'tmp/'
SitemapGenerator::Sitemap.sitemaps_host = 'http://america-hunt-dev.s3.amazonaws.com/'
SitemapGenerator::Sitemap.sitemaps_path = 'sitemaps/'
SitemapGenerator::Sitemap.adapter = SitemapGenerator::S3Adapter.new(fog_provider: 'AWS',
                                                                    aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
                                                                    aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
                                                                    fog_directory: 'america-hunt-dev',
                                                                    fog_region: 'us-west-2')

SitemapGenerator::Sitemap.create do
  add browse_path, priority: 0.8, changefreq: 'daily'

  Page.find_each do |page|
    add page_path(page), lastmod: page.updated_at
  end

  Location.states.each do |st|
    # [properties['name'], abbreviation]
    add "states/#{st[1]}/locations"
  end

  Location.approved.find_each do |loc|
    add location_path(loc), lastmod: loc.updated_at
  end

  BlogCategory.find_each do |blog_cat|
    add blog_category_path(blog_cat), lastmod: blog_cat.updated_at
  end

  add posts_path, priority: 0.8, changefreq: 'daily'

  Post.find_each do |post|
    add post_path(post), lastmod: post.updated_at
  end
end
