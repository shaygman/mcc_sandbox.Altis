//==================================================================MCC_fnc_spotEnemy
// Example:[_type]  call MCC_fnc_spotEnemy;
// <IN>
//	_type:					string - type of enemy to spot
//
// <OUT>
//		<Nothing>
//===========================================================================================================================================================================
private ["_type","_markerName","_path","_pos","_markerClass","_text"];
_type = [_this, 0, "", [""]] call BIS_fnc_param;

if (_type == "") exitWith {};
player globalRadio "SentEnemyDetectedClose";

_markerName = (getplayerUID player) + str floor time;
_path = "";
_pos = if (!isnil "MCC_ACEKeyPos") then {MCC_ACEKeyPos} else {screenToWorld [0.5,0.5]};


switch (_type) do {
    case "Fire Team": {
    	_markerClass = "o_inf";
    	_text = _type;
   };

   case "Squad": {
    	_markerClass = "o_inf";
    	_text = _type;
   };

   case "Section": {
    	_markerClass = "o_inf";
    	_text = _type;
   };

   case "Platoon": {
    	_markerClass = "o_inf";
    	_text = _type;
   };

   case "motorized": {
    	_markerClass = "o_motor_inf";
    	_text = "";
   };

   case "armor": {
    	_markerClass = "o_armor";
    	_text = "";
   };

   case "air": {
    	_markerClass = "o_air";
    	_text = "";
   };

   case "naval": {
    	_markerClass = "o_naval";
    	_text = "";
   };

   case "art": {
    	_markerClass = "o_art";
    	_text = "";
   };

   case "minefield": {
    	_markerClass = "MinefieldAP";
    	_text = "";
   };

    default {
     	_markerClass = "o_inf";
    	_text = _type;
    };
};

player globalRadio "CuratorWaypointPlacedAttack";
[[_markerName, _path, _pos, _markerClass, _text, time, "default"] ,"MCC_fnc_PDAcreatemarker", playerside,false] call BIS_fnc_MP;

titleText ["Marker Added","PLAIN DOWN"];
titleFadeOut 10;