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
run "rm app/assets/javascripts/application.js"
run "rm app/assets/stylesheets/application.css"
run "mkdir app/views/application"

inside 'app' do
  inside 'assets' do
    copy_file 'stylesheets/application.css'
    copy_file 'javascripts/application.js'
  end
  inside 'views' do
    inside 'application' do
      template  'home.html.erb'
      template  '_navbar.html.erb'
      template  '_head.html.erb'
      copy_file '_side.html.erb'
    end
    template 'layouts/application.html.erb'
  end
end

inside 'vendor' do
  directory 'assets' # Copio todo lo de AdminLTE en vendor.
  inside 'assets' do
    inside 'javascripts' do 
      run "ln -s ../plugins/ plugins" # Crear enlaces simbólicos.
    end
    inside 'stylesheets' do 
      run "ln -s ../plugins/ plugins" # Crear enlaces simbólicos.
    end
  end
end

# Configuración de errores de formularios
copy_file 'config/initializers/form_errors.rb'

# Agrego root path por defecto.
route "root to: 'application#home'"

if yes?("¿GitFlowear?")
  after_bundle do
    git :init
    git flow: :init
    run "rm .gitignore"
    copy_file 'gitignore', '.gitignore'
    git add: "."
    git commit: %Q{ -m 'Initial commit' }
  end
end