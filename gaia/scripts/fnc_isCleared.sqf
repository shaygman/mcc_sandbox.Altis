private ["_pos","_IsBlackListed"];
/* ----------------------------------------------------------------------------
Function: fnc_isCleared

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
_side						= _this select 1;

_IsBlackListed 	= false;
_TempArray 			= [];

switch (_side) do
		{
		  case west				: {_TempArray =MCC_GAIA_BREADCRUMBS_WEST; };
		  case east				: {_TempArray =MCC_GAIA_BREADCRUMBS_EAST; };
		  case independent: {_TempArray =MCC_GAIA_BREADCRUMBS_INDEP; };
		};


{
	if ((_pos distance (_x select 0))<MCC_GAIA_CLEARRANGE) 
	exitWith {_IsBlackListed = true;}
		
}forEach _TempArray;

_IsBlackListed