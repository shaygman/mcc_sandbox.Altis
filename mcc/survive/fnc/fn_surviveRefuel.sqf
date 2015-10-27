/*=================================================================MCC_fnc_surviveRefuel=================================================================================
  Refuel vehicle infront of the player
  <In>
  		_itemClass: 		STRING magazine class will be removed on use.
  		_returnItem: 		STRING magazine class item will return to inventory such as empty bottle class.
  		_amount: 			  INTEGER number between 0-1 amount of fuel to take or give to the vehicle
  		_take         	BOOLEAN true - remove fuel, false - add fuel
*/
private ["_vehicle","_fuel","_returnItem","_amount","_take","_displayName"];
_itemClass =  param [0,"",[""]];
_returnItem = param [1,"",[""]];
_amount = param [2,0,[0]];
_take = param [3,true,[true]];

_vehicle = cursorTarget;

player playMoveNow "AinvPknlMstpSlayWrflDnon_medic";
player removeMagazine _itemClass;

if (_vehicle isKindof "LandVehicle" || _vehicle isKindof "LandVehicle") then {
  if (_take) then {
    _fuel = (fuel _vehicle) - _amount;
    _displayName = getText (configfile >> "CfgMagazines" >> _itemClass >> "displayName");
    TitleText [format ["Filling %1...",_displayName], "PLAIN DOWN",0.5];
  } else {
    _fuel = (fuel _vehicle) + _amount;
    _displayName = getText (configfile >> "CfgVehicles" >> typeof _vehicle >> "displayName");
    TitleText [format ["Refueling %1...",_displayName], "PLAIN DOWN",0.5];
  };
  [[[_vehicle,_fuel], {(_this select 0) setFuel (_this select 1);}], "BIS_fnc_spawn", _vehicle, false, false] call BIS_fnc_MP;
};

if (_returnItem != "") then {
  player addMagazine _returnItem;
};