//==================================================================fnc_DoInfPatrol===============================================================================================
// Generate some stuff to do for our awesome patrol
// Example: [_group,_zone] call fnc_DoInfPatrol
// spirit 14-1-2014
//===========================================================================================================================================================================	
private ["_group","_NrOfBuildingWp","_zone","_pos"];

_group 			= _this select 0; 

_class = _group getVariable ["GAIA_class",[]];
_zone	 = (((_group) getVariable ["GAIA_zone_intend",[]])select 0);

if (!IsNil("_class") and !Isnil("_zone")) then
{
		switch(_class) do
		{
				//Infantry
				case "Infantry": 
					{ _dummy= [_group,_zone] call fnc_DoPatrolInf;};
				case "ReconInfantry": 
					{ _dummy= [_group,_zone] call fnc_DoPatrolRecon;};	
				case "MechanizedInfantry": 
					{ _dummy= [_group,_zone] call fnc_DoPatrolMechInf;};								
				case "MotorizedInfantry": 
					{ _dummy= [_group,_zone] call fnc_DoPatrolMotorInf;};								
				case "Car": 
					{ _dummy= [_group,_zone] call fnc_DoPatrolCar;};		
				case "MotorizedRecon": 
					{ _dummy= [_group,_zone] call fnc_DoPatrolMotorRecon;};			
				case "Ship": 
					{ _dummy= [_group,_zone] call fnc_DoPatrolShip;};												
				case "Submarine": 
					{ _dummy= [_group,_zone] call fnc_DoPatrolShip;};									
				case "Helicopter": 
					{ _dummy= [_group,_zone] call fnc_DoPatrolHeli;};	
				//Autonomous for now the same as heli (might change later)
				case "Autonomous": 
					{ _dummy= [_group,_zone] call fnc_DoPatrolHeli;};																	
			
		};
		//Lets set the current Order.
		_group setVariable ["GAIA_Order"							, "DoPatrol", false];
		//Also note when we gave that order and where the unit was. It gives us a chance to check his progress and to 'unstuck' him if needed.
		//Also all orders have a lifespan. MCC_GAIA_ORDERLIFETIME
		_group setVariable ["GAIA_OrderTime"					, Time, false];
		_group setVariable ["GAIA_OrderPosition"			, (position leader _group), false];
};

true


