//==================================================================MCC_fnc_breakdown=========================================================================================
//Breakdown MCC crate into supplies
// Example:[_object] spawn MCC_fnc_breakdown;
// <IN>
//	_object:					Object- object.
//
// <OUT>
//		<nothing>
//===========================================================================================================================================================================
#define MCC_fuelItems [["MCC_fuelCan"],["MCC_fuelbot"]]
#define MCC_repairItems [["MCC_ductTape"],["MCC_butanetorch"],["MCC_oilcan"],["MCC_metalwire"],["MCC_carBat"],["MCC_canOpener"],["MCC_screwdriver"],["MCC_matches"]]

private ["_breakdownArray","_counter","_itemClass","_object","_wepHolder"];
_object = [_this, 0, objNull, [objNull]] call bis_fnc_param;

switch (typeof _object) do {
    case "MCC_crateSupply": {
    	_breakdownArray = MCC_repairItems;
    	_counter = 4;
    };
    case "MCC_crateFuel": {
    	_breakdownArray = MCC_fuelItems;
    	_counter = 4;
    };
    default {
    	_breakdownArray = U_MAGAZINES + U_UNDERBARREL +U_GRENADE + U_EXPLOSIVE;
    	_counter = 8;
    };
};

deleteVehicle _object;
_wepHolder = "GroundWeaponHolder" createVehiclelocal getpos _object;
_wepHolder setpos getpos _object;

for "_i" from 1 to _counter do {
	_itemClass = (_breakdownArray call bis_fnc_selectRandom) select 0;
	_wepHolder addMagazineCargoGlobal [_itemClass,1]
};