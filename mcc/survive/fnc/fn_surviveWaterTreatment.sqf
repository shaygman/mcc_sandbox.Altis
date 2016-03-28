/*=================================================================MCC_fnc_surviveWaterTreatment=================================================================================
  Turn murky water into clean water, can be used to switch any object with another
  <In>
  		_itemCLass: 		STRING magazine class will be removed on use.
  		_returnItem: 		STRING magazine class item will return to inventory such as empty bottle class.
  		_removeObject:	STRING magazine class that will be removed also. Leave "" for not effect
  		_text:          STRING custom text to show.
*/
private ["_returnItem","_text","_removeObject","_displayName"];
_itemClass =  param [0,"",[""]];
_returnItem = param [1,"",[""]];
_removeObject = param [2,"",[""]];
_text = param [3,"",[""]];

player playMoveNow "AinvPknlMstpSlayWrflDnon_medic";
switch (true) do {
  case (isClass (configFile >> "CfgMagazines" >> _itemClass)) : {player removeMagazine _itemClass;_displayName = getText (configfile >> "CfgMagazines" >> _itemClass >> "displayName");};
  case (isClass (configFile >> "CfgWeapons" >> _itemClass)) : {player removeItem _itemClass;_displayName = getText (configfile >> "CfgWeapons" >> _itemClass >> "displayName");};
  case (isClass (configFile >> "CfgGlasses" >> _itemClass)) : {player removeItem _itemClass;_displayName = getText (configfile >> "CfgGlasses" >> _itemClass >> "displayName");};
};

if (_returnItem != "") then {
	switch (true) do {
    case (isClass (configFile >> "CfgMagazines" >> _returnItem)) : {player addMagazine _returnItem;};
    case (isClass (configFile >> "CfgWeapons" >> _returnItem)) : {player additem _returnItem;};
    case (isClass (configFile >> "CfgGlasses" >> _returnItem)) : {player additem _returnItem;};
  };
};

TitleText [format ["%1 %2...",_text, _displayName], "PLAIN DOWN",0.5];

if (_removeObject != "") then {
	switch (true) do {
        case (isClass (configFile >> "CfgMagazines" >> _removeObject)) : {player removeMagazine _removeObject;};
        case (isClass (configFile >> "CfgWeapons" >> _removeObject)) : {player removeItem _removeObject;};
        case (isClass (configFile >> "CfgGlasses" >> _removeObject)) : {player removeItem _removeObject;};
      };
};