// GIUSEPPE SILVI

dlyslider = nentry("[1]delay[style:knob]", 0.0000, 5.000);
drywet = hslider("drywet", 0.500, 0.000, 1.000, 0.100);

//process(x) = _ , drywet <: _ , -(1), _, _ : *, * ( + <: @(dlyslider),_ ) ~_;

fdl(x) 	= @ * x, sqrt(1-c)*x
			with {
				c=(nentry("[1]pan[style:knob]",0,-90,90,1)-90.0)/-180.0;
			};

process		= fdl;