*** Luis Miguel Gomez Londoño y Julian David Mendoza Ruiz
***Códigos: 201729597 y 201730830
*** Constantes *******************************************

Scalar
    a Tiempo de adaptacion de un nuevo integrante al proyecto /2/
    c Constante de adelanto del proyecto. /2/
    m Adelanto minimo para cualquier proyecto. /3/
    N1 Personal inicial del equipo de software. /6/
    Per Personal máximo agregado    /3/
    ;
***Sets***************************************************

Set proyectos Proyectos del problema
 /p1*p3/;

 
***Parametros      ****************************

parameter T(proyectos) Tiempo inicial requerido para cumplir el proyecto n.
    /p1 8, p2 14 , p3 14/;

$ontext    
parameter Ni(proyectos) Personal inicial del proyecto n.
    /p1 10, p2 10, p3 10/;
$offtext

parameter R(proyectos) Retraso máximo que puede tener el proyecto n.
    /p1 6, p2 2, p3 2/;
parameter B(proyectos) Periodo en que se agrega personal al proyecto n.
    /p1 1, p2 0, p3 0/;


***Variables*********************************************
Integer variable P(proyectos) Tiempo final requerido para cumplir el proyecto n.

Integer variable Nf(proyectos) Personal final del proyecto n.

*Integer variable B(proyectos) Periodo en que se agrega personal al proyecto n.

Integer variable Ni(proyectos) Personal inicial del proyecto n.

variable z Variable de la función objetivo

Equations

funcObjetivo Función objetivo del problema

tiempoFinal(proyectos) Tiempo final de cada proyecto

tiempoFinalN1(proyectos) Tiempo final de cada proyecto mas de N1.

restPersonalFinal(proyectos) Restricción de que el personal final debe ser mayor o igual al inicial para todo proyecto n.

restRetrasoMaximo(proyectos) Restriccion para que el tiempo final - inicial del proyecto sea menor que lo maximo autorizado.

restAdelantoMinimo(proyectos) Restriccion para que el tiempo del proyecto ini-final cumpla con el adelanto minimo.

restAgregacionMaximaPersonal(proyectos) Restricción que indica que se puede agregar personal en el último tercio del proyecto.

restPersonalInicial1(proyectos) El personal inicial del proyecto 1 es igual a N1

restPersonalInicial(proyectos) El personal inicial del proyecto 1+i es igual a Nfi

restconcordancia(proyectos) La diferencia entre el personal final y el inicial de un proyecto es 0 cuando el periodo en que se agrega personal es 0.


;

funcObjetivo ..  z =e= sum(proyectos, P(proyectos));

tiempoFinal(proyectos)$(ord(proyectos)<>1) .. P(proyectos) =e= T(proyectos)+ (Nf(proyectos)-Ni(proyectos))*(a+B(proyectos)) - (Ni(proyectos)-Ni('p1'))*c;

tiempoFinalN1(proyectos)$(ord(proyectos)=1) .. P(proyectos) =e= T(proyectos)+ (Nf(proyectos)-N1)*(a+B(proyectos));

restPersonalFinal(proyectos) .. Nf(proyectos) =g= Ni(proyectos);

restRetrasoMaximo(proyectos) .. P(proyectos) - T(proyectos) =l= R(proyectos) ;

restAdelantoMinimo(proyectos)$(ord(proyectos)<>1) .. T(proyectos)- P(proyectos) =g= m;

restAgregacionMaximaPersonal(proyectos) .. B(proyectos)=l=(T(proyectos)*(1/3));

restPersonalInicial1(proyectos)$(ord(proyectos)=1) .. Ni(proyectos) =e= N1; 

restPersonalInicial(proyectos)$(ord(proyectos)<>1).. Ni(proyectos) =e= Nf('p1');

restconcordancia(proyectos) .. Nf(proyectos)-Ni(proyectos) =l= B(proyectos)*1000;


*Option Subsystems;
*$ontext
Model model1 /all/;

*option minlp = CONOPT ;
option mip = CPLEX;

solve model1 using mip minimizing z;

Display z.l;

Display Ni.l;

Display Nf.l;

Display B;

Display T;

Display P.l;


*$offtext
