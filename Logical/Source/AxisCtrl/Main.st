
PROGRAM _INIT
	(* INIT AXIS *)
	FOR i:= 1 TO MAX_AXIS DO
		
		MpAxisBasic_0[i].Enable	:= TRUE;
		
		AxisSequence.parameters[i].Position		:= 100;
		AxisSequence.parameters[i].Velocity		:= 10.0;
		AxisSequence.parameters[i].Acceleration	:= 50.0;
		AxisSequence.parameters[i].Deceleration	:= 50.0;
	
	END_FOR;
		
END_PROGRAM

PROGRAM _CYCLIC

	
	(* CYCLIC AXIS *)
	MpAxisBasic_0[1].MpLink		:= ADR(gAxis_1);
	MpAxisBasic_0[1].Parameters	:= ADR(AxisSequence.parameters[1]);
	MpAxisBasic_0[1]();

	MpAxisBasic_0[2].MpLink		:= ADR(gAxis_2);
	MpAxisBasic_0[2].Parameters	:= ADR(AxisSequence.parameters[2]);
	MpAxisBasic_0[2]();	
	
	(* Axis actions *)
	AxisCtrlStatusAction;
	
	

END_PROGRAM

PROGRAM _EXIT
	
	(* EXIT AXIS *)
	FOR i:= 1 TO MAX_AXIS DO
		MpAxisBasic_0[1].Enable	:= FALSE;
	END_FOR;
	
END_PROGRAM

