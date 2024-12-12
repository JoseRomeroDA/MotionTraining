
TYPE
	AxisSequence_typ : 	STRUCT 
		cmd : AxisSequence_cmd_typ;
		status : AxisSequence_status_typ;
		io : AxisSequence_io_typ;
		state : AxisSequence_enum;
	END_STRUCT;
	AxisSequence_cmd_typ : 	STRUCT 
		Enable : ARRAY[1..MAX_AXIS]OF BOOL;
		ErrorReset : ARRAY[1..MAX_AXIS]OF BOOL;
		Update : ARRAY[1..MAX_AXIS]OF BOOL;
		Power : ARRAY[1..MAX_AXIS]OF BOOL;
		Home : ARRAY[1..MAX_AXIS]OF BOOL;
		MoveVelocity : ARRAY[1..MAX_AXIS]OF BOOL;
		MoveAbsolute : ARRAY[1..MAX_AXIS]OF BOOL;
		Stop : ARRAY[1..MAX_AXIS]OF BOOL;
		JogPositive : ARRAY[1..MAX_AXIS]OF BOOL;
		JogNegative : ARRAY[1..MAX_AXIS]OF BOOL;
	END_STRUCT;
	AxisSequence_status_typ : 	STRUCT 
		PowerMotors : BOOL;
		StartSequence : BOOL;
		StopSequence : BOOL;
		Active : ARRAY[1..MAX_AXIS]OF BOOL;
		Error : ARRAY[1..MAX_AXIS]OF BOOL;
		StatusID : ARRAY[1..MAX_AXIS]OF BOOL;
		UpdateDone : ARRAY[1..MAX_AXIS]OF BOOL;
		Position : ARRAY[1..MAX_AXIS]OF BOOL;
		Velocity : ARRAY[1..MAX_AXIS]OF BOOL;
		CommandBusy : ARRAY[1..MAX_AXIS]OF BOOL;
		CommandAborted : ARRAY[1..MAX_AXIS]OF BOOL;
		PowerOn : ARRAY[1..MAX_AXIS]OF BOOL;
		IsHomed : ARRAY[1..MAX_AXIS]OF BOOL;
		InVelocity : ARRAY[1..MAX_AXIS]OF BOOL;
		InPosition : ARRAY[1..MAX_AXIS]OF BOOL;
		MoveActive : ARRAY[1..MAX_AXIS]OF BOOL;
		MoveDone : ARRAY[1..MAX_AXIS]OF BOOL;
	END_STRUCT;
	AxisSequence_io_typ : 	STRUCT 
	END_STRUCT;
	AxisSequence_enum : 
		(
		WAIT := 0,
		STEP_1 := 10,
		STEP_2 := 20,
		STEP_3 := 30,
		STEP_4 := 40,
		STEP_5 := 50,
		STEP_6 := 60,
		STEP_7 := 70,
		STEP_8 := 80,
		ERROR := 100
		);
END_TYPE