
PROGRAM _INIT
	(* Insert code here *)
	 
END_PROGRAM

PROGRAM _CYCLIC
	(* Insert code here *)
	AutoSequence.status.powerMotors	:= AutoSequence.io.di_PowerMotors;
	AutoSequence.status.startMotors	:= AutoSequence.io.di_StartSequence;
	AutoSequence.status.stopMotor	:= AutoSequence.io.di_StopSequence;
	
	IF EDGEPOS(AutoSequence.status.powerMotors)  THEN
		AutoSequence.cmd.powerMotor	:= TRUE;	
	ELSIF	EDGENEG (AutoSequence.status.powerMotors) THEN
		AutoSequence.cmd.powerMotor	:= FALSE;
	END_IF;
	
	
	IF AutoSequence.state <> (STEP_8) THEN
		AutoSequence.par.speedMovement		:= 1000;//720;
		AutoSequence.par.acceleration		:= 7200;
		AutoSequence.par.deceleration		:= 7200;
	ELSE 
		AutoSequence.par.speedMovement		:= 1000;//1440;
		AutoSequence.par.acceleration		:= 7200;
		AutoSequence.par.deceleration		:= 7200;
	END_IF
	
//	IF AutoSequence.state = (STEP_8) THEN
//		AutoSequence.par.direction	:= 1;
//	ELSE
//		AutoSequence.par.direction	:= 0;
//	END_IF;

	
	CASE AutoSequence.state OF
		WAIT: 
			
			
			IF	AutoSequence.cmd.powerMotor THEN
				AutoSequence.state				:= STEP_1;
			END_IF;
		  
		STEP_1: 
			
			
			IF	AutoSequence.status.startMotors  THEN
				AutoSequence.cmd.home			:= TRUE;
			END_IF;
			
			IF AutoSequence.status.homingDone[1] AND AutoSequence.status.homingDone[2] AND AutoSequence.status.startMotors  THEN
				AutoSequence.cmd.home		:= FALSE;
				AutoSequence.state			:= STEP_2;
			END_IF;
		
		STEP_2: //+180� Axis 1
			
			AutoSequence.par.distance[1]		:= 180;
			AutoSequence.cmd.moveRelative[1]	:= TRUE;
			
			IF(* (AutoSequence.status.actPositon[1] = 180) OR *)AutoSequence.status.MoveAdditiveDone[1] THEN
				AutoSequence.cmd.moveRelative[1]	:= FALSE;
				AutoSequence.state					:= STEP_3;
			END_IF;
				
		STEP_3: //+180 Axis 2
			AutoSequence.par.distance[2]		:= 180;
			AutoSequence.cmd.moveRelative[2]	:= TRUE;
			
			IF (*(AutoSequence.status.actPositon[2] = 180) AND*) (AutoSequence.status.MoveAdditiveDone[2]) THEN
				AutoSequence.cmd.moveRelative[2]	:= FALSE;
				AutoSequence.state					:= STEP_4;
			END_IF;	
		
		STEP_4: //+180 Axis 1
			AutoSequence.par.distance[1]			:= 180;
			AutoSequence.cmd.moveRelative[1]		:= TRUE;
			
			IF (*(AutoSequence.status.actPositon[1] = 180) AND *)AutoSequence.status.MoveAdditiveDone[1] THEN
				AutoSequence.cmd.moveRelative[1]	:= FALSE;
				AutoSequence.state					:= STEP_5;
			END_IF;
				
		STEP_5:	//+180 Axis 2
			
			AutoSequence.par.distance[2]		:= 180;
			AutoSequence.cmd.moveRelative[2]	:= TRUE;
			
			IF (*(AutoSequence.status.actPositon[2] = 180) AND*) (AutoSequence.status.MoveAdditiveDone[2]) THEN
				AutoSequence.cmd.moveRelative[2]	:= FALSE;
				AutoSequence.state					:= STEP_6;
			END_IF;	
			
		STEP_6: //+180 Axis 1
			AutoSequence.par.distance[1]		:= 180;
			AutoSequence.cmd.moveRelative[1]	:= TRUE;
			
			IF (*(AutoSequence.status.actPositon[1] = 180) AND*) AutoSequence.status.MoveAdditiveDone[1] THEN
				AutoSequence.cmd.moveRelative[1]	:= FALSE;
				AutoSequence.state				:= STEP_7;
			END_IF;
				
		STEP_7: //+180 Axis 2
			AutoSequence.par.distance[2]		:= 180;
			AutoSequence.cmd.moveRelative[2]	:= TRUE;
			
			IF (*(AutoSequence.status.actPositon[2] = 180) OR*) (AutoSequence.status.MoveAdditiveDone[2]) THEN
				AutoSequence.cmd.moveRelative[2]	:= FALSE;
				AutoSequence.state				:= STEP_8;
			END_IF;	
		
		STEP_8: 
			AutoSequence.par.distance[1]		:= -540;
			AutoSequence.par.distance[2]		:= -540;
			
			AutoSequence.cmd.moveRelative[1]	:= TRUE;
			AutoSequence.cmd.moveRelative[2]	:= TRUE;
			
			IF (AutoSequence.status.actPositon[1] = (-540)) AND (AutoSequence.status.actPositon[2] = (-540))
				AND (( AutoSequence.status.MoveAdditiveDone[1]) AND (AutoSequence.status.MoveAdditiveDone[2])) THEN
				AutoSequence.cmd.moveRelative[1]	:= FALSE;
				AutoSequence.cmd.moveRelative[2]	:= FALSE;
				AutoSequence.state					:= WAIT;
			END_IF;	
			
	END_CASE;
	
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM
