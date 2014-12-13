//=================================================================MCC_fnc_medicEffects=========================================================================================
//Handle clients medic effects
//=============================================================================================================================================================================
private ["_bleeding","_remaineBlood","_maxBleeding","_ypos","_ratio","_blink"];

//Zeus open
if (!isNull(findDisplay 312)) exitWith {};

//Bleeding
if (missionNamespace getvariable ["MCC_medicBleedingEnabled",false]) then
{
	_bleeding = player getVariable ["MCC_medicBleeding",0];
	_maxBleeding = missionNamespace getvariable ["MCC_medicBleedingTime",200];
	_remaineBlood = player getvariable ["MCC_medicRemainBlood",_maxBleeding];

	if (isnil "MCC_medicBleedingPPEffectColor") then
	{
		MCC_medicBleedingPPEffectColor = ppEffectCreate ["ColorCorrections", 1522];
		MCC_medicBleedingPPEffectColor ppEffectForceInNVG True;

		MCC_medicBleedingPPEffectBlur = ppEffectCreate ["DynamicBlur", 440];
		MCC_medicBleedingPPEffectBlur ppEffectForceInNVG True;
	};

	//Loose blood
	if (_bleeding > 0.1) then
	{
		if ((player getVariable ["MCC_clientEffectsTime",time-5]) < time) then
		{
			[_bleeding * 100] spawn BIS_fnc_bloodEffect;
			[[[netid player,player], format ["WoundedGuyA_0%1",(floor (random 8))+1]], "MCC_fnc_globalSay3D", true, false] spawn BIS_fnc_MP;
			player setVariable ["MCC_clientEffectsTime",time+5+random 10];
		};

		_remaineBlood = _remaineBlood - _bleeding;
		player setVariable ["MCC_medicRemainBlood",_remaineBlood, true];
		if (_remaineBlood<=0) then {[player,player] spawn MCC_fnc_unconscious;};
	};

	//Regain Blood
	if (_bleeding == 0 && _remaineBlood < _maxBleeding) then
	{
		_remaineBlood = _remaineBlood + (0.1*(player getvariable ["MCC_bleedingRegMulti",1]));
		player setVariable ["MCC_medicRemainBlood",_remaineBlood, true];
	};

	//Blood loss effects
	_ratio = (_remaineBlood/_maxBleeding);
	if (_ratio < 0.9) then
	{
		MCC_medicBleedingPPEffectColor ppEffectEnable TRUE;
		MCC_medicBleedingPPEffectBlur ppEffectEnable TRUE;

		if (random 1 < 0.05 && _ratio <0.5) then
		{
			MCC_medicBleedingPPEffectColor ppEffectAdjust [0.8,0.8,0, [0,0,0,0], [0,0,0,_ratio], [0.8,0.8,0.8,1]];
			MCC_medicBleedingPPEffectColor ppEffectCommit 0.05;
			if (getFatigue player < _ratio) then {player setFatigue _ratio};
			sleep 0.05;
		};

		MCC_medicBleedingPPEffectColor ppEffectAdjust [1, 1, 0, [1, 1, 1, 0], [1, 1, 1, _ratio], [0.75, 0.25, 0, 1.0]];
		MCC_medicBleedingPPEffectColor ppEffectCommit 1;

		MCC_medicBleedingPPEffectBlur ppEffectAdjust [(1 - _ratio) min 0.3];
		MCC_medicBleedingPPEffectBlur ppEffectCommit 1;
	}
	else
	{
		MCC_medicBleedingPPEffectColor ppEffectEnable false;
		MCC_medicBleedingPPEffectBlur ppEffectEnable false;
	};
};
