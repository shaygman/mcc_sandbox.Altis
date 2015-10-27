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

_displayName = getText (configfile >> "CfgMagazines" >> _itemClass >> "displayName");

player playMoveNow "AinvPknlMstpSlayWrflDnon_medic";
player removeMagazine _itemClass;

if (_returnItem != "") then {
  player addMagazine _returnItem;
};

TitleText [format ["%1 %2...",_text, _displayName], "PLAIN DOWN",0.5];

if (_removeObject != "") then {
  player removeMagazine _removeObject;
};