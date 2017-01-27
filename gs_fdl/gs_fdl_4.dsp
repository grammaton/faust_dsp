dlyslider = hslider("delay", 5.000, 0.000, 100.000, 0.001);
drywet = hslider("drywet", 0.500, 0.000, 1.000, 0.100);

//process = _ , drywet <: _ , -(1), _, _ : *, * ( + <: @(dlyslider),_ ) ~_;

process = _ , 1. <: _ , -(1), _, _ : *, * ( + <: @(5.2316),_ ) ~_;