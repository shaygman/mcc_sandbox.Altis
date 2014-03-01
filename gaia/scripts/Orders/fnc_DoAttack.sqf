//==================================================================fnc_DoInfPatrol===============================================================================================
// Generate some stuff to do for our awesome patrol
// Example: [_group,_zone] call fnc_DoInfPatrol
// spirit 14-1-2014
//===========================================================================================================================================================================	
private ["_group","_NrOfBuildingWp","_zone","_pos","_TargetPos"];

_group 			= _this select 0; 
_TargetPos	=	_this select 1;


//Combat Requirements
if ( 
			((_group getVariable  ["GAIA_Order",""])!="DoAttack") 
			or
			(((_group getVariable  ["GAIA_OrderPosition",[0,0,0]]) distance _TargetPos)>0)
	 )
then
{			//Check Attack Requirements
			_class = _group getVariable ["GAIA_class",[]];
			
			
			if (!IsNil("_class") ) then
			{
					switch(_class) do
					{
						
							//Infantry
							case "Infantry": 
								{ _dummy= [_group,_TargetPos] call fnc_DoAttackInf;};
							case "ReconInfantry": 
								{ _dummy= [_group,_TargetPos] call fnc_DoAttackRecon;};	
							case "Car": 
								{ _dummy= [_group,_TargetPos] call fnc_DoAttackCar;};		
							case "MotorizedRecon": 
								{ _dummy= [_group,_TargetPos] call fnc_DoAttackMotorRecon;};		
							case "MechanizedInfantry": 
								{ _dummy= [_group,_TargetPos] call fnc_DoAttackMechInf;};		
							case "MotorizedInfantry": 
								{ _dummy= [_group,_TargetPos] call fnc_DoAttackMotorInf;};		
							case "Tank": 
								{ _dummy= [_group,_TargetPos] call fnc_DoAttackMotorRecon;};										
							case "Helicopter": 
								{ _dummy= [_group,_TargetPos] call fnc_DoAttackHeli;};			
							//Autonomous for now the same
							case "Autonomous": 
								{ _dummy= [_group,_TargetPos] call fnc_DoAttackHeli;};																										
							case "Ship": 
								{ _dummy= [_group,_TargetPos] call fnc_DoAttackShip;};										
						
					};
					
					sleep 0.1;
					//Lets set the current Order.
					_group setVariable ["GAIA_Order"							, "DoAttack", false];
					//Also note when we gave that order and where the unit was. It gives us a chance to check his progress and to 'unstuck' him if needed.
					//Also all orders have a lifespan. MCC_GAIA_ORDERLIFETIME
					_group setVariable ["GAIA_OrderTime"					, Time, false];
					_group setVariable ["GAIA_OrderPosition"			, _TargetPos, false];
			};
};
true


