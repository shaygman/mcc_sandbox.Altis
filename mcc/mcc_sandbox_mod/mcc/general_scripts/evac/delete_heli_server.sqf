private ["_option", "_clase", "_lastpos", "_lastdir","_evac","_evac_p","_evac_p_type","_heliType"];

_option			= _this select 0; 
_evac			= _this select 1; 
if (isnil "_evac") exitWith {}; 
_heliType		= typeof _evac;
_evac_p 		= driver _evac;
_evac_p_type 	= getText (configFile >> "CfgVehicles" >> _heliType >> "crew");

switch (_option) do
	{
   		case 0:		//Delete pilot
		{
			if (isnil "_evac_p") exitWith {}; 
			_evac_p action ["getOut", vehicle _evac_p];
			sleep 2;
			deletegroup (group _evac);	//case we want to delete the pilot
			deletevehicle _evac_p;
		}; 
		case 1:
		{
		_evac_p = (group _evac) createUnit [_evac_p_type, getpos _evac, [], 0, "NONE"];		//spawn pilot
		_evac_p assignAsDriver _evac;
		_evac_p moveindriver _evac;
		};
		case 2:
		{ 
			{deleteVehicle _x} forEach (crew _evac);
			deletegroup (group _evac);	//case we want to delete the whole shabang
			deletevehicle _evac;
			deletevehicle _evac_p;
		};
		
	};


