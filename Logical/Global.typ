
TYPE
	AutoSequence_typ : 	STRUCT 
		cmd : AutoSequence_cmd_typ;
		status : AutoSequence_status_typ;
		par : AutoSequence_par_typ;
		state : AutoSequence_state_enum;
		io : AutoSequence_io_typ;
	END_STRUCT;
	AutoSequence_cmd_typ : 	STRUCT 
		powerMotor : BOOL;
		startMotor : BOOL;
		stopMotor : BOOL;
		moveAbsolute : BOOL;
		moveRelative : ARRAY[1..2]OF BOOL;
		home : BOOL;
		homeMode : USINT;
		ErrorAcknowledge : ARRAY[1..2]OF BOOL;
		AutoSequenceDisabled : BOOL;
	END_STRUCT;
	AutoSequence_status_typ : 	STRUCT 
		powerMotors : BOOL;
		startMotors : BOOL;
		stopMotor : BOOL;
		homingDone : ARRAY[1..2]OF BOOL;
		actPositon : ARRAY[1..2]OF REAL;
		MoveAdditiveDone : ARRAY[1..2]OF BOOL;
		finalPosition : ARRAY[1..2]OF BOOL;
		errorActive : ARRAY[1..2]OF BOOL;
		AutoSequenceDisabled : BOOL;
		doPowerMotorsOff : BOOL;
		doPowerMotorsON : BOOL;
		doStartCycleActive : BOOL;
		doStartCycleInactive : BOOL;
		doStopCycleActive : BOOL;
		doStopCycleInactive : BOOL;
		doManualMode : BOOL;
		doErrorActive : BOOL;
	END_STRUCT;
	AutoSequence_par_typ : 	STRUCT 
		deceleration : REAL;
		acceleration : REAL;
		speedMovement : REAL;
		distance : ARRAY[1..2]OF REAL;
		direction : USINT;
		homePosition : ARRAY[1..2]OF REAL;
		homeMode : USINT;
	END_STRUCT;
	AutoSequence_io_typ : 	STRUCT 
		di_PowerMotors : BOOL;
		di_StartSequence : BOOL;
		di_StopSequence : BOOL;
		do_powerMotorsOff : BOOL;
		do_powerMotorsON : BOOL;
		do_startCycleActive : BOOL;
		do_startCycleInactive : BOOL;
		do_stopCycleActive : BOOL;
		do_manualMode : BOOL;
		do_errorActive : BOOL;
	END_STRUCT;
	AutoSequence_state_enum : 
		(
		WAIT,
		STEP_1,
		STEP_2,
		STEP_3,
		STEP_4,
		STEP_5,
		STEP_6,
		STEP_7,
		STEP_8,
		ERROR,
		MANUAL
		);
END_TYPE
