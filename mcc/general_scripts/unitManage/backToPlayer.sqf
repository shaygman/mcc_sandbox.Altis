private ["_caller","_groupSide", "_group","_hijackedSide","_delete","_preUnit"];
_caller = _this select 0;	//Who activate the script
If (!(isPlayer _caller) || !(local player)) exitWith{};

_delete = false; 

//If we came here because we died then delete the old character if it respawned. 
if (!alive _caller) then 
{
	waituntil{alive player};
	_preUnit = vehicle player; 
	_delete = true; 
}; 
_hijackedSide = side _caller;


switch (format ["%1", MCC_Prev_Side]) do 
	{
	case "EAST": //East
		{
		_groupSide = east;
		}; 
		
	case "WEST": //West
		{
		_groupSide = west;
		};
		
	case "GUER": //Resistance
		{
		_groupSide = resistance;
		};
	};
	
_group = creategroup _groupSide;
[MCC_Prev_Player] joinSilent _group;
[_caller] joinSilent _group;
_caller removeaction MCC_backToplayerIndex; 
_caller removeaction mcc_actionInedx; 

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
	if (MCC_Prev_GroupIsLeader) then 
	{
		 [[2, compile format ["(group %1) selectLeader %1",player]], "MCC_fnc_globalExecute", leader group player, false] spawn BIS_fnc_MP;
	};
};

deleteGroup _group;

_ppgrain ppEffectEnable false;
MCC_hijack_effect ppEffectEnable false;

if (isnil "MCC_PrevHijacked_Group" || isnull MCC_PrevHijacked_Group) then
{
	_group = creategroup _hijackedSide;
}
else
{
	_group = MCC_PrevHijacked_Group;
};
[_caller] joinSilent _group;

if (MCC_Prev_HijackedGroupIsLeader) then
{
	(group _caller) selectLeader _caller;
	//[[2, compile format ["(group %1) selectLeader %1",_caller]], "MCC_fnc_globalExecute", leader group _caller, false] spawn BIS_fnc_MP;
}; 

if (_delete) then 
{
	if (!isnil "_preUnit") then {deletevehicle _preUnit};
}; 
