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
// Def: Temperatura en t inf (analítico), Unidad: Kelvin
TinfA=326.4027

function [t,T] = ObtenerTemperaturaPorEuler();
    // Condiciones iniciales
    t(1)=t0
    T(1)=Tamb
    TinfEncontrado = %F
    TinfE=0
    tinfE=0
    U=0
    
    i=1
    while (t(i)<=tf) && ~TinfEncontrado
        u=(1/(m*Ca))*((((V0^2)*((1-(%e^((-a)*t(i)))*cos(w*t(i)))^2))/R)+(Tamb*((k*5*(l^2))/d)))
        T(i+1)=T(i)+(u-gma*T(i))*dt
        Tdif=(abs(TinfA-T(i)))/(abs(TinfA-T(1)))
        U=U+((((V0^2)*((1-(%e^((-a)*t(i)))*cos(w*t(i)))^2))/R)*dt)
        disp(U)
        if(Tdif <= (1/100)) then
            TinfEncontrado = %T;
            TinfE=T(i)
            tinfE=t(i)
            disp("Tiempo a esperar para que la temperatura llegue a estado de régimen estacionario (en forma numérica):")
            disp(tinfE)
            disp("Temperatura en régimen estacionario (en forma numérica):")
            disp(TinfE)
            disp("Gasto de energía eléctrica necesario para llegar al régimen de estado estacionario(en forma numérica):")
            disp(U)
        end
        t(i+1)=t(i)+dt
        i=i+1
    end
endfunction

// Obtenemos los puntos por Metodo de Euler
[t,T] = ObtenerTemperaturaPorEuler()
