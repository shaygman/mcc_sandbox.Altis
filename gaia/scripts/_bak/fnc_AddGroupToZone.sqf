/* ----------------------------------------------------------------------------
Function: fnc_AddGroupToZone

Description:
	Function adds a group to a zone (Marker on Map -> see MCC). 
	-Fill MCC_GAIA_GROUPS 

Parameters:
	- Group
	- Marker (String)
	
Optional:
	- <NONE>

Returns:
	true/false

Author:
	Spirit

---------------------------------------------------------------------------- */

private ["_group"
				,"_Zone"
				,"_local_intel"
				,"_blacklist"
				,"_siz"
				,"_nrgroups"
				,"_X"
				,"_Y"];
				
_group = _this select 0;
_zone  = _this select 1;

// Every group that joins this zone reports in (position in array is the zone number)
_local_intel = MCC_GAIA_GROUPS select (parseNumber _zone );  
_local_intel = _local_intel + [(_group)]; 
 MCC_GAIA_GROUPS  set [ (parseNumber _zone ),_local_intel];

/* 
 //Rebuild the blacklijst area's based on active units in zone.
_blacklist = [];
{ 
_blacklist= _blacklist + [format["%1_from"	,_x]];  
_blacklist= _blacklist + [format["%1_to"		,_x]];  
}  forEach ( MCC_GAIA_GROUPS select (parseNumber _zone ));

MCC_GAIA_BLACKLIST  set [ (parseNumber _zone ),_blacklist];

// relative blacklist SIZE, based on the number of groups we have in this Area
_siz =[];
_siz = getMarkerSize _zone;  
_nrgroups = (count(MCC_GAIA_GROUPS select (parseNumber _zone ))) max 2; 
_X = round((_siz select 0)/_nrgroups)*1.2;  
_Y = round((_siz select 1)/_nrgroups)*1.2;  
MCC_GAIA_BLACKLIST_SIZE set [ (parseNumber _zone ),[_X,_Y]];

// Then either create or Update the markers, as the size has been changed.
{ 
	if (_x==_group) then
		{[_group, _zone] call fnc_CreateBlacklistMarker;}
	else
		{[_x, _zone] call fnc_UpdateBlacklistMarker; jaja=true;}
}  forEach ( MCC_GAIA_GROUPS select (parseNumber _zone ));
*/

true;
