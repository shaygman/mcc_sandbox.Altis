//=================================================================MCC_fnc_rtsTakeControl==============================================================================
//	Order land
//  Parameter(s):
//     _ctrl: CONTROL
//==============================================================================================================================================================================
private ["_group","_targetUnit","_leader","_isLeader","_oldUnit"];
_res = param [1, [], [[]]];

if (count MCC_ConsoleGroupSelected <=0) exitWith {};

_group = MCC_ConsoleGroupSelected select 0;
_targetUnit = leader _group;
MCC_PrevHijacked_Group = netID _group;
MCC_Prev_HijackedGroupIsLeader = true;

if (isplayer _targetUnit) exitwith {
	[9989,"Left click to place",5,true] spawn MCC_fnc_setIDCText;
};

MCC_Prev_Player = player;
MCC_Prev_Group = group Player;
MCC_Prev_GroupIsLeader = if (leader group player == player) then {true} else {false};
MCC_Prev_Side = side player;

_oldUnit = player;
_group = creategroup (side _targetUnit);
[_targetUnit] joinSilent _group;

closeDialog 0;
waitUntil {!dialog};

private ["_camera","_ppgrain"];
_camera = "Camera" camcreate [(getpos _targetUnit) select 0, (getpos _targetUnit) select 1,((getpos _targetUnit) select 2) + 100];
_camera cameraeffect ["internal","back"];
_camera camPrepareFOV 0.900;
_camera camsetTarget _targetUnit;
_camera campreparefocus [-1,-1];
_camera camCommitPrepared 0;
_camera camcommit 0.01;
cameraEffectEnableHUD true;

_ppgrain = ppEffectCreate ["radialBlur", 100];
_ppgrain ppEffectAdjust [0.5, 0.5, 0.3, 0.3];
_ppgrain ppEffectCommit 0;
_ppgrain ppEffectEnable true;

playsound "MCC_woosh";
for "_i" from floor(((getpos _targetUnit) select 2) + 100) to 0 step -3 do
{
	_camera camsetpos [(getpos _targetUnit) select 0, (getpos _targetUnit) select 1,_i];
	_camera camcommit 0.01;
	sleep 0.01;
};

_camera cameraEffect ["TERMINATE", "BACK"];
camdestroy _camera;
_camera = nil;

removeSwitchableUnit _oldUnit;
_group selectLeader player;
selectPlayer _targetUnit;

deletegroup _group;

_ppgrain ppEffectEnable false;
MCC_hijack_effect = ppEffectCreate ["radialBlur", 100];
MCC_hijack_effect ppEffectAdjust [1, 1, 0.4, 0.4];
MCC_hijack_effect ppEffectCommit 0;
MCC_hijack_effect ppEffectEnable true;

MCC_backToplayerIndex = _targetUnit addaction ["<t color=""#CC0000"">Back To Player</t>", MCC_path + "mcc\general_scripts\unitManage\backToPlayer.sqf",[], 0,false, false, "","vehicle _target == vehicle _this"];

_ok = _targetUnit addEventHandler ["Killed", format ["[_this select 0] execVM '%1mcc\general_scripts\unitManage\backToPlayer.sqf'",MCC_path]];

if (MCC_PrevHijacked_Group != "") then {
	[player] joinSilent _group;
	waituntil {group player == (groupFromNetID MCC_PrevHijacked_Group)};

	if (isMultiplayer) then {
		[[2, compile format ["(groupFromNetID '%1') selectLeader objectFromNetId '%2'",netID (group Player), netID player]], "MCC_fnc_globalExecute", leader group player, false] spawn BIS_fnc_MP;
	} else {
		(group player) selectLeader player;
	};
};