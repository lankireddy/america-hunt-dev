set :branch, 'develop'
set :stage, :production
set :rails_env, :production

raise <<-WARNING
  HEY! You need to enter your autoscale group name in config/deploy/production.rb.
  You can get the name from the AWS console by going to Services > EC2 > Autoscale Groups (on the left).
  Delete this message once you have this configured.'
WARNING

autoscale '<AUTOSCALE_GROUP_NAME>', user: 'apps', roles: [:app, :web, :db]
