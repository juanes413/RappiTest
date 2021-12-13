# RappiTest

# Capas de UI o vista

## Main.storyboard
Diseño por storyboard

Controllador de resultado de peliculas
## MainViewController.swift

Controlador de detalle de pelicula
## DetailViewController.swift

# Capa de persistencia (CoreData)

Encargada de almacenar en coredata (cache), la informacion de las peliculas descargadas
## CoreDataUtil.swift

# Capa de red

Encargado de conectarse el endpoint y descargar la informacion.
## APIService.swift

# Capa de negocio

Encarga de gestionar y llamar las otras capas 
## DataBaseManager.swift

Capa de datos-modelos
## Movie+CoreDataProperties.swift
## Movie+CoreDataClass.swift
## MovieItem.swift
## TypeCategory.swift

# 1
La responsabilidad unica es que una funcion, clase u objeto, se encargue de si y solo si realizar una acción o una tarea, 
logrando con esto la encapsulacion de la funcionalidad. (1 de los principios SOLID).

# 2
1. Bien estructurado
2. Bien documentado
3. Que cumpla los principios solid.
4. Nombre de los metodos y variables acorde a su funcion.
5. Escalable
6. Optimizado


# Se agrega screenshot de la app y cuenta con la funcionalidad de offline.
