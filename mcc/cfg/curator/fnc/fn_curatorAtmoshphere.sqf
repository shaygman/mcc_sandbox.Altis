//============================================================MCC_fnc_curatorAtmoshphere========================================================================================
// Manage atmosphere
//===========================================================================================================================================================================
private ["_pos","_module","_resualt","_atmosphere"];
_module = [_this, 0, objNull, [objNull]] call BIS_fnc_param;
if (isNull _module) exitWith {};

_pos = getpos _module;

//did we get here from the 2d editor?
if (typeName (_module getVariable ["atmosphere",true]) == typeName 0) exitWith {

	_atmosphere =  (_module getVariable ["_atmosphere",14]);
	[_pos, 0, _atmosphere] spawn MCC_fnc_deleteBrush;
};

//Not curator exit
if (!(local _module) || isnull curatorcamera) exitWith {};

_resualt = ["Add Atmosphere",[
 						["Atmosphere",["Custom","Random","Clear","Cloudy","Rain","Storm","Sandstorm","Blizzard","Snow","Heat Wave","Remove All"]],
 						["Dust",false],
 						["Snow",false],
 						["Papers",false],
 						["Mist",false],
 						["Fog",false],
 						["Leaves",false],
 						["Wind Sounds",false],
 						["Color",["None","Cold","Murky","Green","Sand","Yellow","Hot","Gray"]],
 						["Film Grain",["None","Low","Medium","Heavy"]],
 						["Overcast",10],
 						["Wind",10],
 						["Waves",10],
 						["Rain",10],
 						["Lightnings",10],
 						["Fog",10]
 					  ]] call MCC_fnc_initDynamicDialog;

if (count _resualt == 0) exitWith {deleteVehicle _module};
private ["_effect","_dust","_snow","_papers","_mist","_fog","_leaves","_wind","_color","_grain","_weather","_preDefinedWeather"];
_effect = (["custom","random","clearWeather","cloudy","rain","stormy","sandstorm","storm","snow","heatwave","clear"]) select (_resualt select 0);
_dust = _resualt select 1;
_snow = _resualt select 2;
_papers = _resualt select 3;
_mist = _resualt select 4;
_fog = _resualt select 5;
_leaves = _resualt select 6;
_wind = _resualt select 7;
_color = (["none","cold","murky","green","sand","yellow","hot","gray"]) select (_resualt select 8);
_grain = (["none","low","medium","heavy"]) select (_resualt select 9);
_weather = [(_resualt select 10)/10,(_resualt select 11)/10,(_resualt select 12)/10,(_resualt select 13)/10,(_resualt select 14)/10,(_resualt select 15)/10];

if (_effect == "random") then {
	_effect = [["clearWeather","cloudy","rain","stormy","sandstorm","storm","snow","heatwave"],[0.4,0.15,0.15,0.15,0.045,0.045,0.045,0.045]] call bis_fnc_selectRandomWeighted;
};

switch (_effect) do {
    case "clearWeather": {
    	_weather = [(random 0.2), (random 0.2), (random 0.2), 0, 0,(random 0.1),0];
    	_effect = "custom";
    };

    case "cloudy": {
    	_weather =[0.4 + (random 0.2), 0.4 +(random 0.2), 0.4 +(random 0.2), 0.4 +(random 0.2), 0.4 +(random 0.2),0 +(random 0.2),0];
    	_effect = "custom";
    };

    case "rain": {
    	_weather = [0.6 + (random 0.2), 0.6 +(random 0.2), 0.6 +(random 0.2), 0.6 +(random 0.2), 0.6 +(random 0.2),0.1 +(random 0.2),0];
    	_effect = "custom";
    };

    case "stormy": {
    	_weather = [0.8 + (random 0.2), 0.8 +(random 0.2), 0.8 +(random 0.2), 0.8 +(random 0.2), 0.8 +(random 0.2),0.3 +(random 0.2),0];
    	_effect = "custom";
    };
};

[_effect,false,_dust,_snow,_papers,_mist,_fog,_leaves,_wind,_color,_grain,_weather] remoteExec ["MCC_fnc_ppEffects", 0, true];


deleteVehicle _module;