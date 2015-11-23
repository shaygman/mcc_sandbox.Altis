//==================================================================MCC_fnc_ACEdropAmmobox=======================================================================================
//Drop MCC ammbox in ACE
// Example: ["MCC_ammoBoxMag","MCC_ammoBox"] call MCC_fnc_ACEdropAmmobox;
// <IN>
//  _mag:                    STRING: magazine class name  - will be removed from the player
//  _itemClass:              STRING: object class name  - will be spawned next the player
//
// <OUT>
//      <nothing>
//
//===========================================================================================================================================================================
private ["_mag","_itemClass","_handPos","_utility"];
_mag = param [0, "", [""]];
_itemClass = param [1, "", [""]];

if (_mag == "" || _itemClass == "") exitWith {};

player removeItem _mag;
player playactionNow "putdown";
sleep 0.3;
_handPos = player selectionPosition "LeftHand";
_utility = _itemClass createvehicle (player modelToWorld [(_handPos select 0),(_handPos select 1)+1.8,(_handPos select 2)]);
_utility setpos (player modelToWorld [(_handPos select 0),(_handPos select 1)+1,0]);
_utility setdir getdir player;