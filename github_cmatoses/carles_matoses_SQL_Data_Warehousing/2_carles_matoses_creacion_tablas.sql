-- Crear la tabla bootcamps
 CREATE TABLE bootcamps (
    id_bootcamp SERIAL PRIMARY KEY,
    nombre VARCHAR(255),
    edicion INT,
    especialidad VARCHAR(255),
    fecha_inicio DATE,
    fecha_fin DATE,
    requisitos_formacion VARCHAR(255),
    requisitos_informaticos VARCHAR(255)
   );
  

-- Crear la tabla profesores
CREATE TABLE profesores (
    id_profesor SERIAL PRIMARY KEY,
    nombre VARCHAR(255),
    apellido VARCHAR(255),
    dni VARCHAR(20),    
    email VARCHAR(255),
    direccion VARCHAR(255),
    telefono VARCHAR(20)
   );
  
  
-- Crear la tabla herramientas
CREATE TABLE herramientas (
    id_herramienta SERIAL PRIMARY KEY,
    nombre_herramienta VARCHAR(255)
   );
  
  
-- Crear la tabla calendario
CREATE TABLE calendario (
    id_calendario SERIAL PRIMARY KEY,
    fecha DATE,
    dia INT,
    semana INT,    
    mes INT,
    año INT
   );
  

-- Crear la tabla pais
CREATE TABLE pais (
    id_pais SERIAL PRIMARY KEY,
    nombre VARCHAR(255),
    continente VARCHAR(255),
    provincia VARCHAR(255),    
    ciudad VARCHAR(255)
   );
  

 -- Crear la tabla notas
CREATE TABLE notas (
    id_notas SERIAL PRIMARY KEY,
    nota_numero NUMERIC,
    nota_nombre VARCHAR(20)
   ); 
  
  

-- Crear la tabla estudiantes
CREATE TABLE estudiantes (
    id_estudiante SERIAL PRIMARY KEY,
    id_pais INT,
    nombre VARCHAR(255),
    apellido VARCHAR(255),
    dni VARCHAR(20),    
    email VARCHAR(255),
    direccion VARCHAR(255),
    telefono VARCHAR(20),
    FOREIGN KEY (id_pais) REFERENCES pais(id_pais)
   );
  

-- Crear la tabla cursos
CREATE TABLE cursos (
    id_cursos SERIAL PRIMARY KEY,
    id_estudiante INT,
    id_profesor INT,
    id_calendario INT,
    id_bootcamp INT,
    id_herramienta INT,
    descripcion VARCHAR(255),
    nivel VARCHAR(255),
    especialidad VARCHAR(255),
    fecha_inicio DATE,
    fecha_final DATE,
    is_activo BOOLEAN,
    FOREIGN KEY (id_estudiante) REFERENCES estudiantes(id_estudiante),
    FOREIGN KEY (id_profesor) REFERENCES profesores(id_profesor),
    FOREIGN KEY (id_calendario) REFERENCES calendario(id_calendario),
    FOREIGN KEY (id_bootcamp) REFERENCES bootcamps(id_bootcamp),
    FOREIGN KEY (id_herramienta) REFERENCES herramientas(id_herramienta)
   );  


  -- Crear la tabla cursos_estudiantes (relación muchos a muchos entre estudiantes_cursos)
CREATE TABLE estudiantes_cursos  (
    id_cursos_estudiantes SERIAL PRIMARY KEY,
    id_cursos INT,
    id_estudiante INT,
    id_notas INT,
    FOREIGN KEY (id_cursos) REFERENCES cursos(id_cursos),
    FOREIGN KEY (id_estudiante) REFERENCES estudiantes(id_estudiante),
    FOREIGN KEY (id_notas) REFERENCES notas(id_notas),
    UNIQUE (id_cursos, id_estudiante)
   );  
  


  -- Insertamos valores en tabla bootcamps
INSERT INTO bootcamps (nombre,edicion,especialidad,fecha_inicio,fecha_fin,requisitos_formacion,requisitos_informaticos) VALUES
('big data',13,'informatica', DATE '2023-07-01', DATE '2023-12-03','grado','minimo'),
('inteligencia artificial',10,'ingenieria',DATE '2023-07-01', DATE '2023-12-03','master','avanzado'),
('backend',15,'informatica',DATE '2023-07-01', DATE '2023-12-03','grado','minimo');


 -- Insertamos valores en tabla profesores
INSERT INTO profesores (nombre,apellido,dni,email,direccion,telefono) VALUES
('pepe','perez','20569824M','pepeperez@gmail.com','calle sevilla 25','620536987'),
('andres','garcia','25685655L','andresgarcia@gmail.com','calle valencia 8','695874521'),
('juan','sanz','65452566N','juansanz@gmail.com','plaza espana 8','771212055'),
('pablo','martinez','5563566P','pablomartinez@gmail.com','avenida barcelona10','846549589');


 -- Insertamos valores en tabla herramientas
INSERT INTO herramientas (nombre_herramienta) VALUES
('tableplus'),
('dbeaver'),
('visual_studio_code'),
('power_bi'),
('tableau'),
('excel');  


 -- Insertamos valores en tabla calendario
INSERT INTO calendario (fecha,dia,semana,mes,año) VALUES
(DATE '2023-06-01',1,22,6,2023),
(DATE '2023-07-01',1,26,7,2023),
(DATE '2023-08-01',1,31,8,2023),
(DATE '2023-09-01',1,35,9,2023),
(DATE '2023-10-01',1,39,10,2023),
(DATE '2023-11-01',1,44,11,2023),
(DATE '2023-12-01',1,48,12,2023); 


 -- Insertamos valores en tabla pais
INSERT INTO pais (nombre,continente,provincia,ciudad) VALUES
('Espana','Europa','Comunidad Valenciana','Valencia'),
('Espana','Europa','Comunidad Valenciana','Madrid'),
('Argentina','America del sur','Ciudad Autonoma de Buenos Aires','Buenos aires'),
('Colombia','America del sur','Cundinamarca','Bogotá');  


 -- Insertamos valores en notas
INSERT INTO notas (nota_numero,nota_nombre) VALUES
(1,'SUSPENSO'),
(2,'SUSPENSO'),
(3,'SUSPENSO'),
(4,'SUSPENSO'),
(5,'APROBADO'),
(6,'APROBADO'),
(7,'NOTABLE'),
(8,'NOTABLE'),
(9,'SOBRESALIENTE'),
(10,'MATRICULA');  

  
 -- Insertamos valores en tabla estudiantes  
INSERT INTO estudiantes (id_pais,nombre,apellido,dni,email,direccion,telefono) VALUES
(1,'javier','lopez','51256984J','javierlopez@gmail.com','calle palencia 5','652365895'),
(1,'pepe','vega','51681635H','pepevega@gmail.com','calle segovia 8','658952146'),
(2,'juan','emiliano','51256984J','juanemiliano@gmail.com','calle paraguay 15','665538397'),
(3,'felipe','duran','51681635H','felipeduran@gmail.com','avenida oeste 18','672124648');  
    

 -- Insertamos valores en tabla cursos
INSERT INTO cursos (id_estudiante,id_profesor,id_calendario,id_bootcamp,id_herramienta,descripcion,nivel,especialidad,fecha_inicio,fecha_final,is_activo) VALUES
(1,2,1,1,1,'curso pandas','intermedio','big data','2023-06-01','2023-08-15','true'),
(1,2,1,1,3,'curso numy','intermedio','big data','2023-06-01','2023-08-15','true'),
(1,2,1,1,2,'curso matplotblib','avanzado','big data','2023-06-01','2023-08-15','true'),
(2,3,2,3,2,'curso ux','intermedio','front','2023-07-01','2023-11-10','false'),
(2,3,2,3,1,'curso maquetacion','iniciacion','front','2023-07-01','2023-11-10','false'),
(2,4,2,3,4,'curso java','avanzado','front','2023-07-01','2023-11-10','false');  

  

 -- Insertamos valores en tabla estudiantes_cursos
INSERT INTO estudiantes_cursos (id_cursos,id_estudiante,id_notas) VALUES
(1,1,6),
(1,2,5),
(1,3,7),
(2,1,8),
(2,2,9),
(2,3,10),
(3,1,3),
(3,2,5),
(3,3,7);  




 




