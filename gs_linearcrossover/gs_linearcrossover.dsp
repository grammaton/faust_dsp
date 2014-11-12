//Crossover shelf filter with equal phase

//for PI and SR and other math things
import("math.lib"); 

F = hslider("Freq", 160, 80, 400, 1);

//radians per sample
srad = (F * 2 * PI ) / SR ; 

//first filter coefficient
ffc = (sin(srad) - 1) / cos(srad) ; 

//second filter coefficient
sfc = (ffc + 1) * 0.5 ;

//allpass = (_,_ <: (*(sfc),_ : + : @(1)), -) ~_ : (!,_); // allpass ok
shelfu = _ : ((- : @(1) <: _ , _ : *(ffc) ,  _ ) ~ _ *(ffc) ) :> + ;

allpu = _ : (- : *(sfc) <: (+ )~_)~_ (+(1): @(1)) : _;

//replace code after "alpu : " when fixed
shelfd =  allpu : (- : *(sfc) <: (+ )~_)~_ (+(1): @(1)) : _  ;

process = shelfd , shelfd - shelfu;