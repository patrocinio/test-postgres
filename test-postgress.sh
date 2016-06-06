# Inspired by http://docs.cloudfoundry.org/buildpacks/ruby/sample-ror.html

DIR=~/workspace-ruby

mkdir -p $DIR
cd $DIR

# Clone the project
git clone https://github.com/cloudfoundry-samples/rails_sample_app

# Logs in to Bluemix
cf login