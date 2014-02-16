/*  fnc_GetZoneStatusBehavior
		
		Purpose:
		Sets the alert level of the zone on which the units will act on.
		
    In		: [zone]
    Out		: [_ZoneStatus,_Behaviour,_CombatMode,_Formation,_Speed]
    
    By Spirit, 7-1-2014
    
*/

private 
["_zone"
,"_Behaviour"
,"_CombatMode"
,"_Formation"
,"_Speed"
,"_side"
,"_ZoneStatus"
];

_zone 			= _this select 0;
_side				= _this select 1;
_Behaviour	="SAFE";		
_CombatMode="GREEN";	
_Formation="COLUMN";	
_Speed = "LIMITED";


switch (_side) do
		{
		  case west				: {_ZoneStatus = (MCC_GAIA_ZONESTATUS_WEST  select  (parseNumber _zone ));};
		  case east				: {_ZoneStatus = (MCC_GAIA_ZONESTATUS_EAST  select  (parseNumber _zone ));};
		  case independent: {_ZoneStatus = (MCC_GAIA_ZONESTATUS_INDEP select  (parseNumber _zone ));};
		};

		

//Lets create the right behaviour for our friends
switch (_ZoneStatus) do
	{
	case (0) 										: {_Behaviour="SAFE";		_CombatMode="GREEN";		_Formation="COLUMN";	_Speed = "LIMITED";};			
	case (1)	 									: {_Behaviour="AWARE";	_CombatMode="YELLOW";		_Formation="WEDGE";		_Speed = "NORMAL";};			
	case (2)										: {_Behaviour="AWARE";	_CombatMode="YELLOW";		_Formation="VEE";			_Speed = "NORMAL";};				
	};	

// Return position

[_ZoneStatus,_Behaviour,_CombatMode,_Formation,_Speed]