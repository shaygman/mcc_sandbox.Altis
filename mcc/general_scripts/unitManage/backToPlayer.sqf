private ["_caller","_groupSide", "_group","_hijackedSide","_delete","_preUnit"];
_caller = _this select 0;	//Who activate the script
If (!(isPlayer _caller) || !(local player)) exitWith{};
if (!alive MCC_Prev_Player) exitWith {systemchat "Previous player is no longer alive"; player removeaction MCC_backToplayerIndex};
_delete = false; 

//If we came here because we died then delete the old character if it respawned. 
if (!alive _caller) then 
{
	waituntil{alive player};
	_delete = true; 
}; 
_preUnit = vehicle player; 
_hijackedSide = side _caller;


_groupSide = switch (format ["%1", MCC_Prev_Side]) do 
		{
			case "EAST": {east}; 			
			case "WEST": {west};			
			case "GUER": {resistance};
			default {civilian};
		};
	
_group = creategroup _groupSide;
[MCC_Prev_Player] joinSilent _group;
[_caller] joinSilent _group;
_caller removeaction MCC_backToplayerIndex; 
player setVariable ["MCC_allowed",true,true];
//_caller removeaction mcc_actionInedx; 

private ["_camera","_ppgrain"];
_camera = "Camera" camcreate [(getpos MCC_Prev_Player) select 0, (getpos MCC_Prev_Player) select 1,((getpos MCC_Prev_Player) select 2) + 100];
_camera cameraeffect ["internal","back"];
_camera camPrepareFOV 0.900;
_camera camsetTarget MCC_Prev_Player;
_camera campreparefocus [-1,-1];
_camera camCommitPrepared 0;
_camera camcommit 0.01;
cameraEffectEnableHUD true;

_ppgrain = ppEffectCreate ["radialBlur", 100];
_ppgrain ppEffectAdjust [0.5, 0.5, 0.3, 0.3];
_ppgrain ppEffectCommit 0;
_ppgrain ppEffectEnable true;

playsound "MCC_woosh"; 				
for "_i" from floor(((getpos MCC_Prev_Player) select 2) + 100) to 0 step -3 do 
{
	_camera camsetpos [(getpos MCC_Prev_Player) select 0, (getpos MCC_Prev_Player) select 1,_i];
	_camera camcommit 0.01;
	sleep 0.01;
}; 


_camera cameraEffect ["TERMINATE", "BACK"];
camdestroy _camera;
_camera = nil; 
				
_group selectLeader player;
selectPlayer MCC_Prev_Player;
player setcaptive false; 

if (!isnull MCC_Prev_Group) then
{
	[player] joinSilent MCC_Prev_Group;
	waituntil {group player == MCC_Prev_Group};
	if (MCC_Prev_GroupIsLeader) then 
	{
		if (isMultiplayer) then
		{
			[[2, compile format ["(groupFromNetID '%1') selectLeader objectFromNetId '%2'",netID (group player), netID player]], "MCC_fnc_globalExecute", true, false] spawn BIS_fnc_MP;
		}
		else
		{
			(group _preUnit) selectLeader _preUnit;
		};
	};
};

_ppgrain ppEffectEnable false;
MCC_hijack_effect ppEffectEnable false;

deleteGroup _group;

if (MCC_PrevHijacked_Group == "") then
{
	_group = creategroup _hijackedSide;
}
else
{
	_group =  groupFromNetID MCC_PrevHijacked_Group;
};

[_preUnit] joinSilent _group;

waituntil {group _preUnit == _group};
if (MCC_Prev_HijackedGroupIsLeader) then
{
	if (isMultiplayer) then
	{
		[[2, compile format ["(groupFromNetID '%1') selectLeader objectFromNetId '%2'",netID (group _preUnit), netID _preUnit]], "MCC_fnc_globalExecute", _preUnit, false] spawn BIS_fnc_MP;
	}
	else
	{
		(group _preUnit) selectLeader _preUnit;
	};
}; 

if (_delete) then 
{
	if (!isnil "_preUnit") then {deletevehicle _preUnit};
}; 
