/*
	Based on Karel Moricky's script adapted to MCC

	Description:
	Show group tooltip.

	Parameter(s):
		0:
			CONFIG - group from CfgORBAT
			ARRAY - group params returned by BIS_fnc_ORBATGetGroupParams
		1: CONTROL - tooltip control
		2: ARRAY - mouse position in format [x,y]

	Returns:
	BOOL
*/
disableserialization;

private ["_classParams","_display","_tooltip","_mousepos","_infoPosX","_infoPosY","_infoPosW","_infoPosH"];
_classParams 	= [_this,0,[],[configfile,[]]] call bis_fnc_param;
_display 		= [_this,1,displaynull,[displaynull]] call bis_fnc_param;
_mousepos 		= [_this,2,[0.5,0.5],[[]]] call bis_fnc_param;
_tooltip 		= _display displayctrl 9511;

if (count _classParams == 0) exitwith {
	//--- Hide the tooltip
	_tooltip ctrlsetfade 1;
	_tooltip ctrlcommit 0;
	false
};

//--- Set text so height can be calculated
_tooltip ctrlsetstructuredtext parsetext (_classParams select 8);
_count = ((count (toArray (_classParams select 8)))/2000)+0.1;

//--- Calculate position
_infoPosX = (_mousePos select 0);
_infoPosY = (_mousePos select 1) + 0.04;
_infoPosW = 0.35;
_infoPosH = ctrltextheight _tooltip + 0.01;// + 0.01;
if (((safezoneX + safezoneW) - _infoPosX) < _infoPosW) then {_infoPosX = (_mousePos select 0) - _infoPosW};
if (((safezoneY + safezoneH) - _infoPosY) < _infoPosH) then {_infoPosY = (_mousePos select 1) - _infoPosH};

//--- Set text
_tooltip ctrlenable false;
_tooltip ctrlsetposition [
	_infoPosX,
	_infoPosY,
	_infoPosW,
	_infoPosH
];
_tooltip ctrlsetfade 0;
_tooltip ctrlcommit 0;

//Reveal background info
_tooltip ctrlShow true;
_tooltip ctrlSetPosition [_infoPosX, _infoPosY,0.15 * safezoneW,_count * safezoneH];
_tooltip ctrlCommit 0;

sleep 1;
_tooltip ctrlShow false;
true