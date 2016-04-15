//==================================================================MCC_fnc_doorBreach================================================================================
// Place a breaching charge on the door
// Example:[_object] spawn MCC_fnc_doorBreach;
// <IN>
//	_object:					Object- object.
//
// <OUT>
//		<nothing>
//=====================================================================================================================================================================
private ["_object","_str","_typeOfSelected","_return","_n","_position","_c4"];
#define MCC_CHARGE "ClaymoreDirectionalMine_Remote_Mag"

_object = _this select 0;

private ["_door","_animation","_phase","_closed","_tempArray"];
_tempArray = [_object]  call MCC_fnc_isDoor;
_door = _tempArray select 0;
_animation = _tempArray select 1;
_phase = _tempArray select 2;
_closed = _tempArray select 3;

if (_door == "") exitWith {};

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
