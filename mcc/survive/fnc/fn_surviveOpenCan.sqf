/*=================================================================MCC_fnc_surviveOpenCan=================================================================================
  Open a can
  <In>
  		_itemCLass: 		STRING magazine class will be removed on use.
  		_returnItem: 		STRING magazine class item will return to inventory such as empty open tuna can
*/
private ["_itemClass","_displayName","_returnItem"];
_itemClass = param [0,"",[""]];
_returnItem = param [1,"",[""]];

_displayName = getText (configfile >> "CfgMagazines" >> _itemClass >> "displayName");

player playMoveNow "AinvPknlMstpSlayWrflDnon_medic";
player removeMagazine _itemClass;

TitleText [format ["Opening %1...",_displayName], "PLAIN DOWN",0.5];

if (_returnItem != "") then {
  player addMagazine _returnItem;
};