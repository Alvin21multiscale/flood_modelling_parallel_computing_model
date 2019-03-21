# flood_modelling_parallel_computing_model
Contains the matlab codes for flood modelling simulations with shallow water equations. 

Using the explicit predictor-corrector scheme to discretize shallow water equations. 

The flux of each computational grid is first computed at the half time-step with an intermediate predictor step using the Godunov-type upwind scheme proposed by Roe, and then adjusted at the full time level with a subsequent corrector step.
