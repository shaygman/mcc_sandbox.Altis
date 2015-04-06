private ["_disp","_rPPEffect","_cPPEffect","_escEH","_infoCtrl","_nextTime","_deathTime","_blink","_remaineBlood","_maxBleeding"];
disableSerialization;

waituntil {dialog};

_disp = _this select 0;
uiNamespace setVariable ["mcc_uncMain", _disp];
#define mcc_uncMain (uiNamespace getVariable "mcc_uncMain")

//PP effects
_rPPEffect = ppEffectCreate ["RadialBlur", 100];
_rPPEffect ppEffectAdjust [0.3, 0.3, 0.15, 0.15];
_rPPEffect ppEffectForceInNVG True;
_rPPEffect ppEffectEnable True;
_rPPEffect ppEffectCommit 0.5;


_cPPEffect = ppEffectCreate ["ColorCorrections", 1555];
_cPPEffect ppEffectAdjust [0,0,0, [0,0,0,0], [0,0,0,1], [1,1,1,1], [0.3,0.3,0,0,0,0.3,0.3]];
_cPPEffect ppEffectForceInNVG True;
_cPPEffect ppEffectEnable True;
_cPPEffect ppEffectCommit 0.1;

//Disable Esc while respawn is on
_escEH = _disp displayAddEventHandler ["KeyDown", "if ((_this select 1) == 1) then { true }"];

//Add EH
(_disp displayCtrl 0) ctrlAddEventHandler ["ButtonClick", "player setDamage 1; closeDialog 0"];

//Hide Second wind		//TODO second wind perk
if !("secondWind" in (player getVariable ["MCC_playersPerks",[]])) then
{
	(_disp displayCtrl 1) ctrlShow false;
};

//Add effects
player setFatigue 1;

//last unconcscious time
_nextTime = player getVariable ["MCC_medicUnconsciousTime", time];
_deathTime = time;
player setVariable ["MCC_medicUnconsciousTime", time+30];
if (_nextTime > _deathTime) then {player setDamage 1; closeDialog 0};

//Time till respawn
_blink = false;
sleep 1;
player allowDamage true;

_maxBleeding = missionNamespace getvariable ["MCC_medicBleedingTime",200];


while {dialog && alive player && (player getvariable ["MCC_medicUnconscious",false])} do
{
	_infoCtrl = (_disp displayCtrl 3);
	_remaineBlood = player getvariable ["MCC_medicRemainBlood",_maxBleeding];
	_infoCtrl progressSetPosition (_remaineBlood/_maxBleeding);
	//_infoCtrl ctrlSetText format ["Blood Level: %1", floor ((_remaineBlood/_maxBleeding)*100)];

	if (_remaineBlood <= 0) then
	{
		closeDialog 0;
		player setCaptive false;
		player setDamage 1;
	};

	if (_blink && random 1 < 0.2) then
	{
		_cPPEffect ppEffectAdjust [0,0,0, [0,0,0,0], [0,0,0,1], [1,1,1,1], [0.3,0.3,0,0,0,0.3,0.3]];
		_cPPEffect ppEffectCommit 1;
		_blink = false;
	};

	if (floor time mod 8 == 0 && random 1 < 0.4 && !_blink) then
	{
		_cPPEffect ppEffectAdjust [0,0,0, [0,0,0,0], [0,0,0,1], [1,1,1,1], [0.5,0.5,0,0,0,0.5,0.5]];
		_cPPEffect ppEffectCommit 1;
		_blink = true;
	};

	if (floor time mod 3 == 0 && random 1 > 0.5) then {player say3D format ["WoundedGuyA_0%1",(floor (random 8))+1]};

	sleep 1;
};

//Cleanup
_disp displayRemoveEventHandler ["KeyDown", _escEH];
ppEffectDestroy  _rPPEffect;
ppEffectDestroy  _cPPEffect;
player setFatigue 0;
player setCaptive false;
player playmoveNow "amovppnemstpsraswrfldnon";

//Remove helper
[player] spawn MCC_fnc_deleteHelper;

closeDialog 0;

waitUntil {alive player};
//Enable ACRE
player setVariable ["acre_sys_core_isDisabled", false, True];

//Enable TF
player setVariable ["tf_voiceVolume", 1, True];
player setVariable ["tf_unable_to_use_radio", false, True];