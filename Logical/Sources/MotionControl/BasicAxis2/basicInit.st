PROGRAM _INIT

(* get axis object *)
Axis1Obj := ADR(gAxis02);

AxisStep := STATE_WAIT; (* start step *)

BasicControl.Parameter.Velocity             := 1000;  (*velocity for movement*)
BasicControl.Parameter.Acceleration         := 5000;  (*acceleration for movement*)
BasicControl.Parameter.Deceleration         := 5000;  (*deceleration for movement*)
BasicControl.Parameter.JogVelocity          := 400;   (*velocity for jogging *)
	
	
	
//	MC_BR_CyclicRead_0.Axis			:= ADR(gAxis02);
//	MC_BR_CyclicRead_0.Enable		:= TRUE;
//	MC_BR_CyclicRead_0.ParID		:= 381; //Temperature sensor: Temperature
//	MC_BR_CyclicRead_0.DataAddress	:= ADR(Axis1SensorTemp);
//	MC_BR_CyclicRead_0.DataType		:= ncPAR_TYP_REAL;	
//	MC_BR_CyclicRead_0.Mode			:= mcEVERY_RECORD;
//	MC_BR_CyclicRead_0();
//	
//	
//	MC_BR_CyclicRead_1.Axis			:= ADR(gAxis02);
//	MC_BR_CyclicRead_1.Enable		:= TRUE;
//	MC_BR_CyclicRead_1.ParID		:= 1637; //Temperature sensor: Temperature
//	MC_BR_CyclicRead_1.DataAddress	:= ADR(Axis1MotorTorque);
//	MC_BR_CyclicRead_1.DataType		:= ncPAR_TYP_UINT;	
//	MC_BR_CyclicRead_1.Mode			:= mcEVERY_RECORD;
//	MC_BR_CyclicRead_1();
END_PROGRAM

