*** Luis Miguel Gomez Londoño y Julian David Mendoza Ruiz
***Códigos: 201729597 y 201730830
*** Constantes *******************************************

*Tiempo de adaptacion de un nuevo integrante al proyecto
*$set a = 2;
Scalar a /2/
*Constante de adelanto del proyecto.
$set b = 3

***Sets***************************************************

Set proyectos Proyectos del problema
 /p1*p3/;
 
***Parametros      ****************************

parameter T(proyectos) Tiempo inicial requerido para cumplir el proyecto n.
    /p1 10, p2 12 , p3 14/;
    
parameter Ni(proyectos) Personal inicial del proyecto n.
    /p1 10, p2 10, p3 10/;
    
parameter R(proyectos) Retraso máximo que puede tener el proyecto n.
    /p1 2, p2 2, p3 2/;
    
parameter B(proyectos) Periodo en que se agrega personal al proyecto n.
    /p1 0, p2 0, p3 0/;
    
***Variables*********************************************
Integer variable P(proyectos) Tiempo final requerido para cumplir el proyecto n.

Integer variable Nf(proyectos) Personal final del proyecto n.

*Positive variable B(proyectos) Periodo en que se agrega personal al proyecto n.

variable z Variable de la función objetivo

Equations

funcObjetivo Función objetivo del problema

tiempoFinal(proyectos) Tiempo final de cada proyecto

restPersonalFinal(proyectos) Restricción de que el personal final debe ser mayor o igual al inicial para todo proyecto n.
;

funcObjetivo ..  z =e= sum(proyectos, P(proyectos));

tiempoFinal(proyectos) .. P(proyectos) =e= T(proyectos)+ (Nf(proyectos)-Ni(proyectos))*(a+B(proyectos));

restPersonalFinal(proyectos) .. Nf(proyectos) =g= Ni(proyectos);

Model model1 /all/;

option mip = CPLEX ;

solve model1 using mip minimizing z;

Display z.l;

Display Nf.l;

