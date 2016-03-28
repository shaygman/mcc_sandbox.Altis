/*=================================================================MCC_fnc_surviveIsCarWithFuel=================================================================================
  check if the is a vehicle with fuel infront of player
  <In>
  		_take: 		BOOLEAN true - check if there fuel in the vehicle. false - only check if there is a vehicle infront
  <Return?
    BOOLEAN
*/
private ["_vehicle","_take"];
_vehicle = cursorTarget;
_take = param [0,true,[true]];

if (_vehicle distance player > 5) exitWith {false};

if (_take) then {
  (_vehicle isKindof "LandVehicle" || _vehicle isKindof "LandVehicle") && fuel _vehicle > 0.2;
} else {
  (_vehicle isKindof "LandVehicle" || _vehicle isKindof "LandVehicle")
};