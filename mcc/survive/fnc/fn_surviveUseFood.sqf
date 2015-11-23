/*=================================================================MCC_fnc_surviveUseFood=================================================================================
  Use food or drink
  <In>
  		_itemCLass: 		STRING magazine class will be removed on use.
  		_calories: 			INTEGER added calories, use negative numbers to reduce
  		_water: 			INTEGER added water, use negative numbers to reduce
  		_returnItem: 		STRING magazine class item will return to inventory such as empty bottle class.
  		_eating: 			BOOLEAN true - eating message, false - drinking message.
  		_foodPoisionChance	INTEGER chance between 1-100 to catch sickness from the food/water
*/
private ["_itemClass","_calories","_water","_displayName","_preCal","_preWater","_returnItem","_eating","_foodPoisionChance"];
_itemClass = param [0,"",[""]];
_calories = param [1,0,[0]];
_water = param [2,0,[0]];
_returnItem = param [3,"",[""]];
_eating = if (param [4,true,[true]]) then {"Eating"} else {"Drinking"};
_foodPoisionChance =  param [5,5,[0]];

player playMoveNow "AinvPknlMstpSlayWrflDnon_medic";
switch (true) do {
  case (isClass (configFile >> "CfgMagazines" >> _itemClass)) : {player removeMagazine _itemClass;_displayName = getText (configfile >> "CfgMagazines" >> _itemClass >> "displayName");};
  case (isClass (configFile >> "CfgWeapons" >> _itemClass)) : {player removeItem _itemClass;_displayName = getText (configfile >> "CfgWeapons" >> _itemClass >> "displayName");};
  case (isClass (configFile >> "CfgGlasses" >> _itemClass)) : {player removeItem _itemClass;_displayName = getText (configfile >> "CfgGlasses" >> _itemClass >> "displayName");};
};

TitleText [format ["%1 %2...",_eating, _displayName], "PLAIN DOWN",0.5];
_preCal = player getVariable ["MCC_calories",4000];
_preWater = player getVariable ["MCC_water",200];

_calories = ((_preCal + _calories) max 0) min 4000;
_water = ((_preWater + _water) max 0) min 200;
player setVariable ["MCC_calories",_calories];
player setVariable ["MCC_water",_water];

if (_returnItem != "") then {
	switch (true) do {
    case (isClass (configFile >> "CfgMagazines" >> _returnItem)) : {player addMagazine _returnItem;};
    case (isClass (configFile >> "CfgWeapons" >> _returnItem)) : {player additem _returnItem;};
    case (isClass (configFile >> "CfgGlasses" >> _returnItem)) : {player additem _returnItem;};
  };
};

//Sick chance
if (random 100 < _foodPoisionChance) then {
	0 spawn {
		sleep 10 + random 600;
		player setVariable ["MCC_surviveIsSick",true];
		TitleText ["You feel sick...", "PLAIN DOWN",0.5];
	};
};