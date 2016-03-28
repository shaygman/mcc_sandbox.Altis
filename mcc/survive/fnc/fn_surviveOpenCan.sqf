/*=================================================================MCC_fnc_surviveOpenCan=================================================================================
  Open a can
  <In>
  		_itemCLass: 		STRING magazine class will be removed on use.
  		_returnItem: 		STRING magazine class item will return to inventory such as empty open tuna can
*/
private ["_itemClass","_displayName","_returnItem"];
_itemClass = param [0,"",[""]];
_returnItem = param [1,"",[""]];

player playMoveNow "AinvPknlMstpSlayWrflDnon_medic";
switch (true) do {
	case (isClass (configFile >> "CfgMagazines" >> _itemClass)) : {player removeMagazine _itemClass;_displayName = getText (configfile >> "CfgMagazines" >> _itemClass >> "displayName");};
	case (isClass (configFile >> "CfgWeapons" >> _itemClass)) : {player removeItem _itemClass;_displayName = getText (configfile >> "CfgWeapons" >> _itemClass >> "displayName");};
	case (isClass (configFile >> "CfgGlasses" >> _itemClass)) : {player removeItem _itemClass;_displayName = getText (configfile >> "CfgGlasses" >> _itemClass >> "displayName");};
};

TitleText [format ["Opening %1...",_displayName], "PLAIN DOWN",0.5];

if (_returnItem != "") then {
	switch (true) do {
		case (isClass (configFile >> "CfgMagazines" >> _returnItem)) : {player addMagazine _returnItem;};
		case (isClass (configFile >> "CfgWeapons" >> _returnItem)) : {player additem _returnItem;};
		case (isClass (configFile >> "CfgGlasses" >> _returnItem)) : {player additem _returnItem;};
	};
};