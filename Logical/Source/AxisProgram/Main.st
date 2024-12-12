
PROGRAM _INIT
	(* INIT AXIS *)
	FOR i:= 1 TO MAX_AXIS DO
		
		MpAxisBasic_0[i].Enable	:= TRUE;
		
		AxisParameters[i].Position		:= 100;
		AxisParameters[i].Velocity		:= 10.0;
		AxisParameters[i].Acceleration	:= 50.0;
		AxisParameters[i].Deceleration	:= 50.0;
	
	END_FOR;
		
END_PROGRAM

PROGRAM _CYCLIC
	
	/////////// PHYSICAL INPUTS ///////////
	AxisSequence.status.PowerMotor	:= AxisSequence.io.di_PowerMotors;	
	AxisSequence.status.StartSequence	:= AxisSequence.io.di_StartSequence;
	AxisSequence.status.StopSequence	:= AxisSequence.io.di_StopSequence;
	
	
	(* CYCLIC AXIS *)
	MpAxisBasic_0[1].MpLink		:= ADR(gAxis_1);
	MpAxisBasic_0[1].Parameters	:= ADR(AxisParameters[1]);
	AxisInfo[1]					:= MpAxisBasic_0[1].Info;
	MpAxisBasic_0[1]();

	MpAxisBasic_0[2].MpLink		:= ADR(gAxis_2);
	MpAxisBasic_0[2].Parameters	:= ADR(AxisParameters[2]);
	AxisInfo[2]					:= MpAxisBasic_0[2].Info;
	MpAxisBasic_0[2]();	
	
	
	

END_PROGRAM

PROGRAM _EXIT
	
	(* EXIT AXIS *)
	FOR i:= 1 TO MAX_AXIS DO
		MpAxisBasic_0[1].Enable	:= FALSE;
	END_FOR;
	
END_PROGRAM

