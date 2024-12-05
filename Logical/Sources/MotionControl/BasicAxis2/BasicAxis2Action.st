
ACTION Axis2CyclicReadAction: 
	MC_BR_CyclicRead_0.Axis			:= ADR(gAxis02);
	MC_BR_CyclicRead_0.Enable		:= TRUE;
	MC_BR_CyclicRead_0.ParID		:= ACP10PAR_TEMP_MOTOR; //Temperature sensor: Temperature
	MC_BR_CyclicRead_0.DataAddress	:= ADR(Axis2SensorTemp);
	MC_BR_CyclicRead_0.DataType		:= ncPAR_TYP_REAL;	
	MC_BR_CyclicRead_0.Mode			:= mcEVERY_RECORD;
	MC_BR_CyclicRead_0();
	
	MC_BR_CyclicRead_1.Axis			:= ADR(gAxis02);
	MC_BR_CyclicRead_1.Enable		:= TRUE;
	MC_BR_CyclicRead_1.ParID		:= ACP10PAR_TORQUE_ACT; 
	MC_BR_CyclicRead_1.DataAddress	:= ADR(Axis2MotorTorque);
	MC_BR_CyclicRead_1.DataType		:= ncPAR_TYP_REAL;	
	MC_BR_CyclicRead_1.Mode			:= mcEVERY_RECORD;
	MC_BR_CyclicRead_1();
	
	MC_BR_CyclicRead_2.Axis			:= ADR(gAxis02);
	MC_BR_CyclicRead_2.Enable		:= TRUE;
	MC_BR_CyclicRead_2.ParID		:= ACP10PAR_PCTRL_S_ACT; 
	MC_BR_CyclicRead_2.DataAddress	:= ADR(Axis2EncoderPosition);
	MC_BR_CyclicRead_2.DataType		:= ncPAR_TYP_DINT;	
	MC_BR_CyclicRead_2.Mode			:= mcEVERY_RECORD;
	MC_BR_CyclicRead_2();
	
END_ACTION

ACTION Axis2Param :
	BasicControl.Parameter.Acceleration	:= AutoSequence.par.acceleration;
	BasicControl.Parameter.Deceleration	:= AutoSequence.par.deceleration;
	BasicControl.Parameter.Direction	:= AutoSequence.par.direction[2];
	BasicControl.Parameter.Velocity		:= AutoSequence.par.speedMovement;
	BasicControl.Parameter.Distance		:= AutoSequence.par.distance[2];
	BasicControl.Parameter.HomePosition	:= AutoSequence.par.homePosition[2];
	BasicControl.Parameter.Position		:= AutoSequence.par.position[2];
END_ACTION

ACTION Axis2Cmd :
	BasicControl.Command.Power				:= AutoSequence.cmd.powerMotor;
	BasicControl.Command.Home				:= AutoSequence.cmd.home;
	BasicControl.Command.MoveAbsolute		:= AutoSequence.cmd.moveAbsolute[2];
	BasicControl.Command.MoveAdditive		:= AutoSequence.cmd.moveRelative[2];
	BasicControl.Command.Stop				:= AutoSequence.cmd.stopMotor;
	BasicControl.Command.ErrorAcknowledge	:= AutoSequence.cmd.ErrorAcknowledge[2];
END_ACTION