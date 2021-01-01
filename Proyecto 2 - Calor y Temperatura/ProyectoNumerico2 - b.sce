clear
// Def: Temperatura ambiente, Unidad: Grados Kelvin
Tamb=283
// Def: Paso de integración Delta t para el método de Euler, Unidad: s
dt=0.1
// Def: Tiempo inicial para el método de Euler, Unidad: s
t0=0
// Def: Tiempo final para el método de Euler, Unidad: s
tf=3600
// Def: Conductividad términa, Unidad: W/m*K
k=0.6
// Def: Lado de la sala cúbica, Unidad: m
l=4
// Def: Ancho de pared, Unidad: m 
d=0.25
// Def: Masa del aire, Unidad: Kg 
m=76.8
// Def: Calor específico del aire, Unidad: J/Kg*K
Ca=1012
// Def: Voltage inicial, Unidad: V
V0=100
// Def: Resistencia, Unidad: Ohm
R=1
// Def: Unidad: rad/s
w=0.02
// Def: Unidad: 1/s
a=0.0035
// Def: Gamma de la fórmula de Calor
gma=(k*5*(l^2))/(d*m*Ca)

function [t,T] = ObtenerTemperaturaPorEuler();
    // Condiciones iniciales
    t(1)=t0
    T(1)=Tamb
    
    i=1
    while t(i)<=tf
        u=(1/(m*Ca))*((((V0^2)*((1-(%e^((-a)*t(i)))*cos(w*t(i)))^2))/R)+(Tamb*((k*5*(l^2))/d)))
        T(i+1)=T(i)+(u-gma*T(i))*dt
        t(i+1)=t(i)+dt
        i=i+1
    end
endfunction

// Obtenemos los puntos por Metodo de Euler
[t,T] = ObtenerTemperaturaPorEuler()

// Configuraciones de la Grafica
xgrid;
xlabel("t (s)","fontsize",4,"color","red")
ylabel("T (K)","fontsize",4,"color","red");
title("Temperatura vs. Tiempo","color","red","fontsize",4);
// Grafica de la trayectoria con Metodo de Euler
plot(t,T,"r")
