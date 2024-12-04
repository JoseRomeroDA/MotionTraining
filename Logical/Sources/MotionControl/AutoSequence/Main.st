
PROGRAM _INIT
	(* Insert code here *)
	 
END_PROGRAM

PROGRAM _CYCLIC
	(* Insert code here *)
	AutoSequence.status.powerMotors	:= AutoSequence.io.di_PowerMotors;
	AutoSequence.status.startMotors	:= AutoSequence.io.di_StartSequence;
	AutoSequence.status.stopMotor	:= AutoSequence.io.di_StopSequence;
	
	AutoSequence.par.homePosition[1]	:= 80;
	AutoSequence.par.homePosition[2]	:= 90;
	
	TON_TurnOffMotors.PT	:= T#2s;

	IF EDGEPOS(AutoSequence.status.powerMotors)  THEN
		AutoSequence.status.doPowerMotorsOff 		:= FALSE;
		AutoSequence.status.doPowerMotorsON			:= TRUE;
		AutoSequence.status.doStartCycleActive 		:= FALSE;
		AutoSequence.status.doStartCycleInactive	:= TRUE;
		AutoSequence.status.doStopCycleInactive		:= FALSE;
		AutoSequence.status.doStopCycleActive		:= FALSE;
		AutoSequence.cmd.powerMotor					:= TRUE;		
	END_IF;
	
	IF (AutoSequence.status.powerMotors)  THEN
		TON_TurnOffMotors.IN	:= TRUE;
	ELSE 
		TON_TurnOffMotors.IN := FALSE;
	END_IF;
	IF TON_TurnOffMotors.Q  OR (AutoSequence.state = ERROR)
		OR (AutoSequence.status.stopMotor) 	THEN
		AutoSequence.cmd.powerMotor					:= FALSE;
		AutoSequence.cmd.moveRelative[1]			:= FALSE;
		AutoSequence.cmd.moveRelative[2]			:= FALSE;
		AutoSequence.status.doPowerMotorsOff 		:= TRUE;
		AutoSequence.status.doPowerMotorsON			:= FALSE;
		AutoSequence.status.doStartCycleInactive 	:= TRUE;
		AutoSequence.status.doStartCycleActive		:= FALSE;
		AutoSequence.status.doStopCycleInactive		:= FALSE;
		AutoSequence.status.doStopCycleActive		:= TRUE;
		AutoSequence.state	 := WAIT;
	END_IF;
	
	IF EDGENEG (AutoSequence.status.stopMotor) THEN
		AutoSequence.status.doStopCycleActive		:= FALSE;
		
	END_IF;	
	IF AutoSequence.state <> (STEP_8) THEN
		AutoSequence.par.speedMovement		:= 100;
		AutoSequence.par.acceleration		:= 7200;
		AutoSequence.par.deceleration		:= 7200;
	ELSIF AutoSequence.state = (STEP_8) THEN
		AutoSequence.par.speedMovement		:= 100;
		AutoSequence.par.acceleration		:= 7200;
		AutoSequence.par.deceleration		:= 7200;
	ELSIF AutoSequence.cmd.AutoSequenceDisabled THEN
		AutoSequence.par.speedMovement;
		AutoSequence.par.acceleration;
		AutoSequence.par.deceleration;
	END_IF
	
	IF AutoSequence.state = (STEP_8) THEN
		AutoSequence.par.direction	:= AXIS_SHIFT_REVERSE; 	//Reverse
	ELSIF AutoSequence.state <> (STEP_8) THEN
		AutoSequence.par.direction	:= AXIS_SHIFT_FORWARD;	//Forward
	ELSIF AutoSequence.cmd.AutoSequenceDisabled	THEN		
		AutoSequence.par.direction;
	END_IF;
	
	IF AutoSequence.status.errorActive[1] OR AutoSequence.status.errorActive[2] THEN
		PWM_Active.Enable				:= TRUE;
		PWM_Active.Period				:= 3;
		PWM_Active.DutyCycle			:= 50;
		AutoSequence.status.doErrorActive	:= PWM_Active.Out;
		AutoSequence.state	:= ERROR; 
	END_IF;
	
	IF EDGEPOS (AutoSequence.cmd.AutoSequenceDisabled) THEN
		AutoSequence.cmd.powerMotor			:= FALSE;
		AutoSequence.cmd.moveRelative[1]	:= FALSE;
		AutoSequence.cmd.moveRelative[2]	:= FALSE;	
		AutoSequence.cmd.home				:= FALSE;
		AutoSequence.par.homeMode			:= mcHOME_DEFAULT;
		AutoSequence.status.doPowerMotorsOff 		:= FALSE;
		AutoSequence.status.doPowerMotorsON			:= FALSE;
		AutoSequence.status.doStartCycleInactive 	:= FALSE;
		AutoSequence.status.doStartCycleActive		:= FALSE;
		AutoSequence.status.doStopCycleInactive		:= FALSE;
		AutoSequence.status.doStopCycleActive		:= FALSE;
		AutoSequence.state	:= MANUAL;
	END_IF;
		
	CASE AutoSequence.state OF
		
		
		WAIT:
			
			IF	AutoSequence.cmd.powerMotor THEN
				AutoSequence.state							:= STEP_1;
			END_IF;
		  
		STEP_1: 
			
			
			IF	EDGEPOS(AutoSequence.status.startMotors)  THEN
				AutoSequence.cmd.startMotor		:= TRUE;
				AutoSequence.cmd.homeMode		:= mcHOME_ABSOLUTE;
				AutoSequence.cmd.home			:= TRUE;
				AutoSequence.status.doStartCycleActive	:= TRUE;
				AutoSequence.status.doStartCycleInactive	:= FALSE;
				
			END_IF;
			
			IF AutoSequence.status.homingDone[1] AND (AutoSequence.status.homingDone[2]) AND (AutoSequence.cmd.startMotor) THEN
				AutoSequence.cmd.startMotor		:= FALSE;
				AutoSequence.cmd.homeMode		:= mcHOME_DEFAULT;
				AutoSequence.cmd.home			:= FALSE;
				AutoSequence.state				:= STEP_2;
			END_IF;
			
		
		STEP_2: //+180° Axis 1
			
			AutoSequence.par.distance[1]		:= 180;
			IF NOT (AutoSequence.status.stopMotor) THEN
				AutoSequence.cmd.moveRelative[1]	:= TRUE;
			ELSE
				AutoSequence.cmd.moveRelative[1]	:= FALSE;
			END_IF;
			
			IF AutoSequence.status.MoveAdditiveDone[1] THEN
				AutoSequence.cmd.moveRelative[1]	:= FALSE;
				AutoSequence.state					:= STEP_3;
			END_IF;
				
		STEP_3: //+180 Axis 2
			AutoSequence.par.distance[2]		:= 180;
			AutoSequence.cmd.moveRelative[2]	:= TRUE;
			
			IF  (AutoSequence.status.MoveAdditiveDone[2]) THEN
				AutoSequence.cmd.moveRelative[2]	:= FALSE;
				AutoSequence.state					:= STEP_4;
			END_IF;	
		
		STEP_4: //+180 Axis 1
			AutoSequence.par.distance[1]			:= 180;
			IF NOT (AutoSequence.status.stopMotor) THEN
				AutoSequence.cmd.moveRelative[1]	:= TRUE;
			ELSE
				AutoSequence.cmd.moveRelative[1]	:= FALSE;
			END_IF;
			
			IF AutoSequence.status.MoveAdditiveDone[1] THEN
				AutoSequence.cmd.moveRelative[1]	:= FALSE;
				AutoSequence.state					:= STEP_5;
			END_IF;
				
		STEP_5:	//+180 Axis 2
			
			AutoSequence.par.distance[2]		:= 180;
			AutoSequence.cmd.moveRelative[2]	:= TRUE;
			
			IF (AutoSequence.status.MoveAdditiveDone[2]) THEN
				AutoSequence.cmd.moveRelative[2]	:= FALSE;
				AutoSequence.state					:= STEP_6;
			END_IF;	
			
		STEP_6: //+180 Axis 1
			AutoSequence.par.distance[1]		:= 180;
			AutoSequence.cmd.moveRelative[1]	:= TRUE;
			
			IF AutoSequence.status.MoveAdditiveDone[1] THEN
				AutoSequence.cmd.moveRelative[1]	:= FALSE;
				AutoSequence.state				:= STEP_7;
			END_IF;
				
		STEP_7: //+180 Axis 2
			AutoSequence.par.distance[2]		:= 180;
			AutoSequence.cmd.moveRelative[2]	:= TRUE;
			
			IF  (AutoSequence.status.MoveAdditiveDone[2]) THEN
				AutoSequence.cmd.moveRelative[2]	:= FALSE;
				AutoSequence.cmd.moveRelative[1]	:= TRUE;
				AutoSequence.cmd.moveRelative[2]	:= TRUE;
				AutoSequence.state				:= STEP_8;
			END_IF;	
		
		STEP_8: 
			AutoSequence.par.distance[1]		:= -540;
			AutoSequence.par.distance[2]		:= -540;
		
			
			IF ( AutoSequence.status.MoveAdditiveDone[1])  THEN			
				AutoSequence.cmd.moveRelative[1]		:= FALSE;
				AutoSequence.status.finalPosition[1]	:= TRUE;
			END_IF;	
			
			IF ( AutoSequence.status.MoveAdditiveDone[2])  THEN			
				AutoSequence.cmd.moveRelative[2]		:= FALSE;
				AutoSequence.status.finalPosition[2]	:= TRUE;
			END_IF;		
			
			IF AutoSequence.status.finalPosition[1] AND AutoSequence.status.finalPosition[2] THEN
				AutoSequence.status.finalPosition[1]	:= FALSE;
				AutoSequence.status.finalPosition[2]	:= FALSE;
				AutoSequence.status.doStartCycleActive	:= FALSE;
				AutoSequence.status.doStartCycleInactive	:= TRUE;
				AutoSequence.state						:= WAIT;
			END_IF;
			
		ERROR:
			AutoSequence.cmd.moveRelative[1]	:= FALSE;
			AutoSequence.cmd.moveRelative[2]	:= FALSE;
			
			AutoSequence.status.doManualMode 	:= FALSE;
			AutoSequence.status.doPowerMotorsON	:= FALSE;
			AutoSequence.status.doPowerMotorsOff:= FALSE;
			
			IF NOT(AutoSequence.status.errorActive[1]) AND NOT(AutoSequence.status.errorActive[2])
				AND NOT (AutoSequence.cmd.AutoSequenceDisabled) THEN
				AutoSequence.state	:= WAIT;
			ELSIF	NOT(AutoSequence.status.errorActive[1]) AND NOT(AutoSequence.status.errorActive[2])
				AND AutoSequence.cmd.AutoSequenceDisabled THEN
				AutoSequence.state	:= MANUAL;
			END_IF;
			
		MANUAL:
			
			//MANUAL MODE ACTIVE		
			PWM_Active.Enable					:= TRUE;
			PWM_Active.Period					:= 3;
			PWM_Active.DutyCycle				:= 50;
			AutoSequence.status.doManualMode	:= PWM_Active.Out;
			
			IF NOT(AutoSequence.cmd.AutoSequenceDisabled) THEN
				AutoSequence.status.doManualMode:= FALSE;
				AutoSequence.state	:= WAIT;
			END_IF;
			
	END_CASE;
	
	AutoSequence.io.do_errorActive			:= AutoSequence.status.doErrorActive;
	AutoSequence.io.do_manualMode			:= AutoSequence.status.doManualMode;
	AutoSequence.io.do_powerMotorsOff		:= AutoSequence.status.doPowerMotorsOff;
	AutoSequence.io.do_powerMotorsON		:= AutoSequence.status.doPowerMotorsON;
	AutoSequence.io.do_startCycleActive		:= AutoSequence.status.doStartCycleActive;
	AutoSequence.io.do_startCycleInactive	:= AutoSequence.status.doStartCycleInactive;
	AutoSequence.io.do_stopCycleActive		:= AutoSequence.status.doStopCycleActive;
	
	PWM_Active();
	TON_TurnOffMotors();
	
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

