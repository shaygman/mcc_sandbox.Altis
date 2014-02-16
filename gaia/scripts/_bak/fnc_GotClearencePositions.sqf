private ["_pos","_IsBlackListed"];
/* ----------------------------------------------------------------------------
Function: fnc_isblacklisted

Description:
	Checks if the given position is witin MCC_GAIA_AWARENESSRANGE.

Parameters:
	- position 
	
Returns:
	true/false

Author:
	Spirit
---------------------------------------------------------------------------- */

_pos 						= _this select 0;
_IsBlackListed 	= false;

{
	if ((_pos distance (_x select 0))<MCC_GAIA_AWARENESSRANGE) 
	exitWith {_IsBlackListed = true;}
		
}forEach MCC_GAIA_BREADCRUMBS;

_IsBlackListed