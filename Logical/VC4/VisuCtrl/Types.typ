
TYPE
	VisuCtrl_typ : 	STRUCT 
		runtime : VisuCtrl_runtime_typ;
		shape : VisuCtrl_shape_typ;
	END_STRUCT;
	VisuCtrl_runtime_typ : 	STRUCT 
		New_Member : USINT;
	END_STRUCT;
	VisuCtrl_shape_typ : 	STRUCT 
		shapeLed : ARRAY[1..3]OF USINT; (*Led para el boton de power, run y stop*)
	END_STRUCT;
END_TYPE
