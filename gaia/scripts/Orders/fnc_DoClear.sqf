//==================================================================fnc_DoInfPatrol===============================================================================================
// Generate some stuff to do for our awesome patrol
// Example: [_group,_zone] call fnc_DoInfPatrol
// spirit 14-1-2014
//===========================================================================================================================================================================	
private ["_group","_NrOfBuildingWp","_zone","_pos","_SpotPos"];

_group 			= _this select 0; 
_SpotPos		=	_this select 1;


//Combat Requirements
if ( 
			((_group getVariable  ["GAIA_Order",""])!="DoClear") 
			or
			(((_group getVariable  ["GAIA_OrderPosition",[0,0,0]]) distance _SpotPos)>0)
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
								{ _dummy= [_group,_SpotPos] call fnc_DoClearInf;};
							case "ReconInfantry": 
								{ _dummy= [_group,_SpotPos] call fnc_DoClearRecon;};	

						
					};
					
					sleep 0.1;
					//Lets set the current Order.
					_group setVariable ["GAIA_Order"							, "DoClear", false];
					//Also note when we gave that order and where the unit was. It gives us a chance to check his progress and to 'unstuck' him if needed.
					//Also all orders have a lifespan. MCC_GAIA_ORDERLIFETIME
					_group setVariable ["GAIA_OrderTime"					, Time, false];
					_group setVariable ["GAIA_OrderPosition"			, _SpotPos, false];
			};
};
true


