
PROGRAM _INIT
	(* Insert code here *)
	 
END_PROGRAM

PROGRAM _CYCLIC
	//Shape Colors
	FOR i := 1 TO 3 DO
		IF AutoSequence.status.doErrorActive THEN
			ShapeColor[i]	:= 253; //naranja
		ELSE	
			ShapeColor[i]; //Negro
		END_IF	;
		
		END_FOR;

		
	IF AutoSequence.status.doPowerMotorsOff THEN
		ShapeColor[1]	:= 15; //Blanco
	ELSIF AutoSequence.status.doPowerMotorsON THEN
		ShapeColor[1]	:= 10; //Verde
	ELSE
		ShapeColor[1]	:= 0;
	END_IF;
		
	IF AutoSequence.status.doStartCycleInactive THEN
		ShapeColor[2]	:= 15; //Blanco
	ELSIF AutoSequence.status.doStartCycleActive THEN
		ShapeColor[2]	:= 10; //Verde
	ELSE
		ShapeColor[2]	:= 0;
	END_IF;

	IF NOT(AutoSequence.cmd.AutoSequenceDisabled)  THEN
		IF (AutoSequence.status.doStopCycleActive) THEN
			ShapeColor[3]	:= 45;
		ELSIF NOT (AutoSequence.status.doStopCycleActive)  THEN		
			ShapeColor[3]	:= 15;
		ELSE
			ShapeColor[3];
		END_IF;
	ELSIF (AutoSequence.cmd.AutoSequenceDisabled)  THEN
		IF 	AutoSequence.status.doManualMode THEN
				ShapeColor[3]	:=  206; //Azul
			ELSE
				ShapeColor[3]	:= 15; //Negro
			END_IF;
	END_IF;
	 
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

