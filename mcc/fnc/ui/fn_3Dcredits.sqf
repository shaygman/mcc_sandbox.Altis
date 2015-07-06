/*										MCC_fnc_3Dcredits
	Author: Karel Moricky tweeked to work in A3 by shay_gman

	Description:
	3D credits.

	Parameter(s):
	_this select 0: STRING - Text
	_this select 1: ARRAY - Position in 3D world

	Returns:
	True
*/
disableserialization;
private ["_text","_pos","_display","_control","_w","_h","_minsDis","_dis","_alpha","_pos2D"];

_text = _this select 0;
_pos = _this select 1;
_minDis = if (count _this > 2) then {_this select 2} else {20};
_fadeDis = if (count _this > 3) then {_this select 3} else {0.5};
if (isnil "BIS_fnc_3dCredits_n") then {BIS_fnc_3dCredits_n = 0;};

if (typename _pos == typename objnull) then {_pos = position _pos};
if (typename _pos == typename "") then {_pos = markerpos _pos};

(("BIS_fnc_3dCredits_" + str BIS_fnc_3dCredits_n) call bis_fnc_rscLayer) cutrsc ["rscDynamicText","plain"];
BIS_fnc_3dCredits_n = BIS_fnc_3dCredits_n + 1;

//#define DISPLAY (uinamespace getvariable "BIS_dynamicText")
//#define CONTROL (DISPLAY displayctrl 9999)

_display = uinamespace getvariable "BIS_dynamicText";
_control = _display displayctrl 9999;

#define DISPLAY	_display
#define CONTROL	_control

CONTROL ctrlsetfade 1;
CONTROL ctrlcommit 0;
CONTROL ctrlsetstructuredtext parsetext _text;
CONTROL ctrlcommit 0;

_w = safezoneW;//0.5;
_h = safezoneH;//0.3;

while {true} do {
	_dis = player distance _pos;
	_alpha = abs ((_dis / _minDis) - _fadeDis);

	if (_alpha <= 1) then {
		_pos2D = worldtoscreen _pos;

		if (count _pos2D > 0) then {
			CONTROL ctrlsetposition [
				(_pos2D select 0) - _w/2,
				(_pos2D select 1) - _h/2,
				_w,
				_h
			];
			//CONTROL ctrlsetbackgroundcolor [0,0,0,0.5];
			CONTROL ctrlsetstructuredtext parsetext _text;
			CONTROL ctrlsetfade (_alpha^3);
			CONTROL ctrlcommit 0;
		} else {
			CONTROL ctrlsetfade 1;
			CONTROL ctrlcommit 0;
		};
	} else {
		CONTROL ctrlsetfade 1;
		CONTROL ctrlcommit 0;
	};
	sleep 0.01;
};