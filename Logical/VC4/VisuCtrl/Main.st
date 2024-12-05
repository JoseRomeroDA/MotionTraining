
PROGRAM _INIT
	(* Insert code here *)
	 
END_PROGRAM

PROGRAM _CYCLIC
	FOR i:= 1 TO 3 DO	
		IF AutoSequence.status.doErrorActive THEN
			PWM_ShapeActive.Enable					:= TRUE;
			PWM_ShapeActive.Period					:= 2;
			PWM_ShapeActive.DutyCycle				:= 50;
			AutoSequence.io.do_LedRed[i]		:= PWM_ShapeActive.Out;
			IF PWM_ShapeActive.Out THEN
				VisuCtrl.shape.shapeLed[i]	:= RED_COLOR;
			ELSE
				VisuCtrl.shape.shapeLed[i]	:= BLACK_COLOR;
			END_IF;
		ELSE 
			PWM_ShapeActive.Enable			:= FALSE;
		END_IF;	
		
		
		IF AutoSequence.cmd.AutoSequenceDisabled AND CountManualSequence <> 3 THEN
			PWM_ShapeActive.Enable					:= TRUE;
			PWM_ShapeActive.Period					:= 2;
			PWM_ShapeActive.DutyCycle				:= 50;
		
			
			IF PWM_ShapeActive.Out THEN
				VisuCtrl.shape.shapeLed[i]	:= YELLOW_COLOR;
			ELSE
				VisuCtrl.shape.shapeLed[i]	:= BLACK_COLOR;
			END_IF;
			
			IF EDGEPOS (PWM_ShapeActive.Out) THEN
				CountManualSequence := CountManualSequence + 1;
			END_IF;
			
		ELSIF AutoSequence.cmd.AutoSequenceDisabled AND (CountManualSequence >= 3) THEN
			PWM_ShapeActive.Enable			:= FALSE;
			VisuCtrl.shape.shapeLed[i]		:= YELLOW_COLOR;
			
		ELSIF NOT(AutoSequence.cmd.AutoSequenceDisabled) AND NOT(AutoSequence.status.doErrorActive) THEN
			PWM_ShapeActive.Enable			:= FALSE;
			//VisuCtrl.shape.shapeLed[i]		:= BLACK_COLOR;
			CountManualSequence				:= 0;
		END_IF;
		
		
	END_FOR;
	
	IF NOT (AutoSequence.status.doErrorActive) AND NOT(AutoSequence.cmd.AutoSequenceDisabled) THEN
		
		IF AutoSequence.status.doPowerMotorsOff	 OR (AutoSequence.state = WAIT) THEN
			VisuCtrl.shape.shapeLed[1]	:= WHITE_COLOR;
		ELSIF AutoSequence.status.doPowerMotorsON THEN
			VisuCtrl.shape.shapeLed[1]	:= GREEN_COLOR;
		END_IF
			
		IF AutoSequence.status.doStartCycleInactive OR (AutoSequence.state = WAIT) THEN
			VisuCtrl.shape.shapeLed[2]	:= WHITE_COLOR;
		ELSIF	AutoSequence.status.doStartCycleActive THEN	
			VisuCtrl.shape.shapeLed[2]	:= GREEN_COLOR;
		END_IF;
		
		IF AutoSequence.status.doStopCycleActive THEN
			VisuCtrl.shape.shapeLed[3]	:= BLUE_COLOR;
		ELSE 
			VisuCtrl.shape.shapeLed[3]	:= BLACK_COLOR;
		END_IF;
	END_IF;
	
	
	PWM_ShapeActive();
	 
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

