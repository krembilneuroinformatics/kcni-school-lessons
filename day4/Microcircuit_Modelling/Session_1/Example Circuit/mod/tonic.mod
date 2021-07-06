: tonic current with rectification
: based on Pavlov et al (J Neuro 2009)

NEURON{
SUFFIX tonic
NONSPECIFIC_CURRENT i
RANGE i, v, a, b, g, e_gaba}

PARAMETER{
g = 0.001 (siemens/cm2)
e_gaba = -80 (millivolt)
}

ASSIGNED{
v (millivolt)
i (milliampere)
a (/ms)
b (/ms)}

STATE{o c}

BREAKPOINT{
SOLVE kin METHOD sparse
i = g*o*(v-e_gaba)}

INITIAL {SOLVE kin STEADYSTATE sparse}

KINETIC kin{
rates(v)
~ o<->c (b, a)   : b is forward rate constant, a backward
CONSERVE o+c=1}

PROCEDURE rates(v(millivolt)) {
LOCAL x, y
UNITSOFF
x = 0.1*(v+20)
if (fabs(x)>1e-6){
a = (50*x)/(1-exp(-x))
} else{
a=0.25*(v^2+(20*v)+200)
}
y = -0.08*(v-10)
if(fabs(x)>1e-6){
b = (20*y)/(1-exp(-y))
} else{
b = -0.064*(v^2-(45*v)+37.5)
}
UNITSON}
