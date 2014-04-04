if(!isServer) exitWith {};
private ["_group"];

_group 			= _this select 0; 
_units  		= units _group;
_vehicles		=  [_group] call  BIS_fnc_groupVehicles;
_sf 				= [];
_uv 				= [];
_crew 			= [];
_gv					= [];


{
	_veh = _x;
	_crew = [];
	{
	 
		if 
			(
			 ( assignedVehicle _x == _veh)
			 and
			 ( alive _x)
			)
	  then
		{
			//player globalchat format ["%1, %2",_veh,_x];
			_crew = _crew + [[(typeof _x),(position _x),damage _x,skill _x,rank _x,(assignedVehicleRole _x),direction _x]];
			_units = _units  - [_x];
			
		}
	}	foreach _units;
	
	_gv = _gv + [[(typeof _veh),position _veh,damage _veh,fuel _veh,_crew]];
	
} foreach _vehicles;

{
	if  ( alive _x) then 
	{
		_uv = _uv + [[typeof _x,(visiblePositionasl _x),damage _x,skill _x,rank _x,direction _x]];
		//deleteVehicle _x;
	};
	
}
foreach _units;

_sf = [_gv,_uv,side _group,(_x getVariable  ["GAIA_zone_intend",[]])];

_pos = position leader _group;

MCC_GAIA_CACHE_STAGE2 = MCC_GAIA_CACHE_STAGE2+ [_pos];
_var2 = "GAIA_CACHE_" + str(_pos); 	
missionNamespace setVariable [_var2, _sf ];


//player globalchat format ["%1",_sf];

{deleteVehicle _x;} foreach units _group;
{deleteVehicle _x;} foreach _vehicles;
deletegroup _group;

