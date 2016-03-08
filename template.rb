### GEMFILE ###
gem 'therubyracer', platforms: :ruby
gem 'font-awesome-rails'
gem 'jquery-ui-rails'
gem 'jquery-turbolinks'
gem 'kaminari'

gem_group :development, :test do
  gem 'pry'
end

def source_paths
  [File.expand_path(File.dirname(__FILE__))]
end

run "rm app/views/layouts/application.html.erb"
run "mkdir app/views/application"

inside 'app' do
  inside 'views' do
    inside 'application' do
      template  'home.html.erb'
      template  '_navbar.html.erb'
      template  '_head.html.erb'
      copy_file '_side.html.erb'
    end
    inside 'layouts' do
      template 'application.html.erb'
    end
  end
end

inside 'vendor' do
  directory 'assets' # Copio todo lo de AdminLTE en vendor.
  #inside 'assets' do
  #  run "ln plugins..." # Crear enlaces simbólicos.
  #end
end

# Agrego root path por defecto.
route "root to: 'application#home'"

#rake "db:create"
#rake "db:migrate"

### 13 ###
#after_bundle do
#  git :init
#  # git flow init
#  git add: "."
#  git commit: %Q{ -m 'Initial commit' }
#end