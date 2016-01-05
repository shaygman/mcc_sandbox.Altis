//==================================================================MCC_fnc_doorBreach=========================================================================================
// Place a breaching charge on the door
// Example:[_object] spawn MCC_fnc_doorBreach;
// <IN>
//	_object:					Object- object.
//
// <OUT>
//		<nothing>
//===========================================================================================================================================================================
private ["_object","_door","_str","_animation","_door","_typeOfSelected","_return","_n","_position","_c4","_phase"];
#define MCC_CHARGE "ClaymoreDirectionalMine_Remote_Mag"
#define MCC_ARMA2MAPS ["takistan","zargabad","chernarus","utes"]

_object = _this select 0;

_door = [_object]  call MCC_fnc_isDoor;
if (_door == "") exitWith {};

if (tolower worldName in MCC_ARMA2MAPS) then {
	_str = [_door,"[01234567890]"] call BIS_fnc_filterString;
	_animation = "dvere"+_str;
} else {
	_animation = _door + "_rot";
};

closeDialog 0;
enableSentences false;
player removeMagazine MCC_CHARGE;
["Placing Charge",4] call MCC_fnc_interactProgress;

_n = 0;
_position = ATLtoASL(player modelToworld [0,_n,1.5]);
while {!lineIntersects [ATLtoASL(player modelToworld [0,0,1]), _position]} do
{
	_n = _n + 0.1;
	_position = ATLtoASL(player modelToworld [0,_n,1]);
};

//Place the charge
_phase = if ((_object animationPhase _animation) > 0) then {0} else {1};
_position = ATLtoASL(player modelToworld [0,_n-0.15,1]);
_c4 = "ClaymoreDirectionalMine_Remote_Ammo_Scripted" createVehicle ATLtoASL _position;
_c4 setpos aslToAtl _position;
_c4 setdir (getdir player);
player addAction ["<t color=""#FF0000"">Detonate Charge</t>", {
								player removeAction (_this select 2);
								((_this select 3) select 1) animate [((_this select 3) select 2), ((_this select 3) select 3)];
								((_this select 3) select 1) setVariable [format ["bis_disabled_%1",((_this select 3) select 4)],0,true];
								sleep 0.7;
								((_this select 3) select 0) setDamage 1;
							}, [_c4,_object,_animation,_phase,_door]];
sleep 1;
enableSentences true;
