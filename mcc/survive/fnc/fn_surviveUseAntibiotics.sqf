/*=================================================================MCC_fnc_surviveUseAntibiotics=================================================================================
  Cure sickness
  <In>
  		_itemCLass: STRING magazine class will be removed on use.
  		_perement: BOOLEAN true - perement effect, false - temporary
*/
private ["_itemClass","_perement"];
_itemClass = _this select 0;
_perement = _this select 1;

player playMoveNow "AinvPknlMstpSlayWrflDnon_medic";
switch (true) do {
  case (isClass (configFile >> "CfgMagazines" >> _itemClass)) : {player removeMagazine _itemClass;};
  case (isClass (configFile >> "CfgWeapons" >> _itemClass)) : {player removeItem _itemClass;};
  case (isClass (configFile >> "CfgGlasses" >> _itemClass)) : {player removeItem _itemClass;};
};


if (player getVariable ["MCC_surviveIsSick",false]) then {
	_perement spawn {
		player setVariable ["MCC_surviveIsSick",false];
		TitleText ["You feel better...", "PLAIN DOWN",0.5];

		if !(_this) then {
			sleep 360 + random 600;
			player setVariable ["MCC_surviveIsSick",true];
			TitleText ["You feel sick...", "PLAIN DOWN",0.5];
		};
	};
};