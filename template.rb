### GEMFILE ###
gem 'therubyracer', platforms: :ruby
gem 'font-awesome-rails'
gem 'jquery-ui-rails'
gem 'jquery-turbolinks'
gem 'kaminari'
gem 'jquery-turbolinks'
gem 'momentjs-rails'
gem 'bootstrap3-datetimepicker-rails'
gem 'bootstrap-glyphicons'
gem_group :development, :test do
  gem 'pry'
end

def source_paths
  [File.expand_path(File.dirname(__FILE__))]
end

run "rm app/views/layouts/application.html.erb"
run "rm app/assets/javascripts/application.js"
run "rm app/assets/stylesheets/application.css.scss"
run "rm app/controllers/application_controller.rb"
run "rm app/helpers/application_helper.rb"
run "rm app/config/environments/test.rb"
run "rm app/config/locales/en.rb"
run "rm app/config/environment.rb"
run "rm app/config/application.rb"
run "mkdir app/views/application"
run "mkdir app/assets/javascripts/initializers"


inside 'app' do
  inside 'assets' do
    inside 'stylesheets' do
      copy_file 'application.css'
      copy_file 'custom-style.css'
      copy_file 'responsive-table.css'
    end
    inside 'javascripts' do
      copy_file 'application.js'
      copy_file 'moment.es.js'
      inside 'initializers' do
        copy_file '01-commons.coffee'
        copy_file '02-select2.coffee'
      end
    end
  end

  inside 'controllers' do
    copy_file 'application_controller.rb'
  end
  inside 'helpers' do
    copy_file 'application_helper.rb'
    copy_file 'form_helper.rb'    
  end
  inside 'config' do
    copy_file 'environment.rb'
    copy_file 'application.rb'
    copy_file 'environments/test.rb'
    copy_file 'initializers/form_errors.rb'
    copy_file 'initializers/date_format.rb'
    copy_file 'initializers/will_paginate_array_fix.rb'
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