# Este template nos servirá para ahorrar tiempo de deployment al crear aplicaciones nuevas.

```
  rails new application_name -m template/template -d mysql
```

## Cosas que hace template.

1- Agregar a vendor /plugins AdminLTE y links simbólicos a /plugins de javascript y stylesheets.

2- Modificar application.js y application.css para usar las librerías correspondientes.

3- Modificar application layout para usar adminlte

4- Agregar vistas:
  application/_head.html.erb
  application/_navbar.html.erb
  application/_side.html.erb
  application/home.html.erb

5- Agregar ruta al index.

6- Usar gemas necesarias.

7- Agregar helpers necesarios (Flash y otros)

8- Actualizar .gitignore

9- Agregar initializers de forms

10- git init & git flow init & git commit "First Commit."