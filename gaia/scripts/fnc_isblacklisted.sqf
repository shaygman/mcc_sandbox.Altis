private ["_pos","_IsBlackListed","_WPPos","_TempArray"];
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
_side						= _this select 1;


_IsBlackListed 	= false;
_WPPos 			= [];
_TempArray 	= [];

switch (_side) do
		{
		  case west				: {_TempArray =MCC_GAIA_WPPOS_WEST; };
		  case east				: {_TempArray =MCC_GAIA_WPPOS_EAST; };
		  case independent: {_TempArray =MCC_GAIA_WPPOS_INDEP; };
		};


{
_WPPos = _WPPos + [_x];
} forEach _TempArray; 


switch (_side) do
		{
		  case west				: {_TempArray =MCC_GAIA_BREADCRUMBS_WEST; };
		  case east				: {_TempArray =MCC_GAIA_BREADCRUMBS_EAST; };
		  case independent: {_TempArray =MCC_GAIA_BREADCRUMBS_INDEP; };
		};

{
	if ((_pos distance (_x select 0))<MCC_GAIA_AWARENESSRANGE) 
	exitWith {_IsBlackListed = true;}
		
}forEach _TempArray+_WPPos;

_IsBlackListed