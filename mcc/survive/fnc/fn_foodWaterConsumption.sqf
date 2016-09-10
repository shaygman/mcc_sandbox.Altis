/*=================================================================MCC_fnc_foodWaterConsumption===============================================================================
	Handles food and water consumption while survival is on
*/
if ((missionNamespace getVariable ["MCC_isLocalHC",false]) || !hasInterface) exitWith {};

private ["_calories","_water","_speedFactor","_lastCheck","_ratio","_caloriesBurn","_waterBurn","_batteryLevel","_light"];

while {(missionNamespace getVariable ["MCC_surviveMod",false])} do 	{

	_lastCheck = player getVariable ["MCC_survivalLastCheckTime",time - 10];

	if (time - _lastCheck >= 10) then {
		//---------Head Torch Battery ------------------
		_light = player getVariable ["MCC_headTorch",objNull];
		if !(isNull _light) then {
			_batteryLevel = player getVariable ["MCC_headTorchBattery",100];
			_batteryLevel = (_batteryLevel - 0.2) max 0;
			player setVariable ["MCC_headTorchBattery",_batteryLevel];
			if (_batteryLevel <= 0) then {
				deleteVehicle _light;
			};
		};


		_calories = player getVariable ["MCC_calories",4000];
		_water = player getVariable ["MCC_water",200];

		_speedFactor = if (vehicle player == player) then {
							if (speed player < 6) then {1} else {
								if (speed player < 14) then {1.5} else {2}};
						} else {0.8};
		_caloriesBurn = (missionNamespace getVariable ["MCC_survivalCaloriesPerHour",1000])/360;
		_waterBurn = (missionNamespace getVariable ["MCC_survivalWaterPerHour",100])/360;
		_calories = (_calories - (_caloriesBurn * _speedFactor)) max 0;
		_water = (_water - ((1-overcast) * _waterBurn*_speedFactor)) max 0;

		//---------Hunger/thirst effects ------------------
		if (isnil "MCC_medicHungerPPEffectColor") then {
			MCC_medicHungerPPEffectColor = ppEffectCreate ["ColorCorrections", 1522];
			MCC_medicHungerPPEffectColor ppEffectForceInNVG True;

			MCC_medicHungerPPEffectBlur = ppEffectCreate ["DynamicBlur", 440];
			MCC_medicHungerPPEffectBlur ppEffectForceInNVG True;
		};


		_ratio = ((_calories/4000) min (_water/200));

		//Sick
		if (player getVariable ["MCC_surviveIsSick",false]) then {_ratio = _ratio *0.5};

		if (_ratio < 0.7) then {
			_ratio = _ratio +0.1;
			MCC_medicHungerPPEffectColor ppEffectEnable TRUE;
			MCC_medicHungerPPEffectBlur ppEffectEnable TRUE;

			if (random 1 < 0.05 && _ratio <0.5) then {
				MCC_medicHungerPPEffectColor ppEffectAdjust [0.8,0.8,0, [0,0,0,0], [0,0,0,_ratio], [0.8,0.8,0.8,1]];
				MCC_medicHungerPPEffectColor ppEffectCommit 0.05;
				if (getFatigue player < _ratio) then {player setFatigue _ratio};
				sleep 0.05;
			};

			MCC_medicHungerPPEffectColor ppEffectAdjust [1, 1, 0, [1, 1, 1, 0], [1, 1, 1, _ratio], [0.75, 0.25, 0, 1.0]];
			MCC_medicHungerPPEffectColor ppEffectCommit 1;

			MCC_medicHungerPPEffectBlur ppEffectAdjust [(1 - _ratio) min 0.3];
			MCC_medicHungerPPEffectBlur ppEffectCommit 1;

			if (_ratio < 0.3) then {
				[_ratio * 100] spawn BIS_fnc_bloodEffect;
				[[[netid player,player], format ["WoundedGuyA_0%1",(floor (random 8))+1]], "MCC_fnc_globalSay3D", true, false] spawn BIS_fnc_MP;
			};
		} else {
			MCC_medicHungerPPEffectColor ppEffectEnable false;
			MCC_medicHungerPPEffectBlur ppEffectEnable false;
		};

		player setVariable ["MCC_calories",_calories, true];
		player setVariable ["MCC_water",_water, true];
		player setVariable ["MCC_survivalLastCheckTime",time];
	};

	sleep 1;
};