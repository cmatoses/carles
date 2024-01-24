Se ha creado el siguiente Dashboard con la idea de que sea una interfaz de búsqueda para usuarios de Airbnb o bien para el departamento de atención al cliente que pueda ayudar a los usuarios a buscar los mejores alojamientos que se adecúan a sus necesidades.

Desarrollos a destacar que se han realizado en el PBIX:

-	Desde “Transform Data” modificamos el campo Bathrooms, ya que vemos cantidades como 10, 20, etc. Creamos una columna nueva llamada “Bathroom real” dividiendo el campo Bathroom entre 10 para obtener valores reales.

-	PUNTUACIÓN ALOJAMIENTO NO UTILIZADA: A través del siguiente campo calculado, se pretendía dar una nota a los alojamientos entre 0 y 10. Se realiza la operación “Number of Reviews” * “Review Scores Rating” y luego se aplicaba una escala de 0 a 10, siendo el valor máximo del resultado de la fórmula el 10. Como se puede ver en el segundo gráfico de la Page2, la gran mayoría se iban al 0 debido a la alta dispersión (muchos valores en blanco o con resultados bajos y pocos con muchas reviews). Por lo tanto, este campo finalmente no se ha utilizado.

-	SCORING: En este campo calculado se realiza la fórmula descrita anteriormente para dar una puntuación al alojamiento (“Number of Reviews” * “Review Scores Rating”)

-	PUNTUACIÓN: Campo calculado que como resultado nos devuelve 10 percentiles para obtener la escala de puntuación entre 0 y 10. Como se puede ver en el primer gráfico de la Page2, ahora sí que tenemos las puntuaciones mejor distribuidas entre los alojamientos
*NOTA: Se realizan estas dos operaciones como columnas calculadas ya que luego necesitaremos filtrar los resultados. Si lo hiciésemos como medidas, no podríamos aplicar los filtros hechos en el Dashboard

-	Tabla “INFORMACIÓN ALOJAMIENTOS”: Se añade la imagen del alojamiento. Lo ideal es que nos rediríjase a su web o se nos abriese una ventana en el navegador sobre la imagen en vez de descargarse.

-	Tabla “INFORMACIÓN ALOJAMIENTOS”: Se añade la URL del anfitrión por si se quiere ver su perfil. Hacemos que aparezca el símbolo de la URL en vez de todo el texto para una mejor experiencia de visualización

-	Tabla “RESUMEN POR PÁIS, CIUDAD Y BARRIO”: Se puede ir desplegando para ir valorando el país, ciudad y barrio que más se adecúe a lo que buscamos.
