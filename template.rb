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
run "rm app/controllers/application_controller.rb"
run "rm app/helpers/application_helper.rb"
run "rm app/config/environments/test.rb"
run "rm app/config/locales/en.rb"
run "rm app/config/environment.rb"
run "rm app/config/application.rb"
run "mkdir app/views/application"

inside 'app' do
  inside 'assets' do
    copy_file 'stylesheets/application.css'
    copy_file 'javascripts/application.js'
    copy_file 'javascripts/init.coffee'
    copy_file 'javascripts/select2_init.coffee'
  end
  inside 'controllers' do
    copy_file 'application_controller.rb'
  end
  inside 'helpers' do
    copy_file 'application_helper.rb'
  end
  inside 'config' do
    copy_file 'environment.rb'
    copy_file 'application.rb'
    copy_file 'environments/test.rb'
    copy_file 'locales/en.rb'
    copy_file 'locales/es.rb'
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

#if yes?("¿Migrar?")
#  password = ask? "Escriba su contraseña de mysql."
#  ...
#end

after_bundle do
  git flow: 'init -d'
  run "rm .gitignore"
  copy_file 'gitignore', '.gitignore'
  git add: "."
  git commit: %Q{ -m 'Initial commit' }
end