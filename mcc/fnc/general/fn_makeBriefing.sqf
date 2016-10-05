//===================================================================MCC_fnc_makeBriefing=================================================================================
//Server Only - create a Logic based briefing
//Example:[[_string, _type ,_missionTittle],"MCC_fnc_makeBriefing",false,false] call BIS_fnc_MP;
// Params:
// 	_string: string, the briefing string
//	_type: interger or string, Integer - pre defined mission type or a string for custom one
//	_missionTittle:  string,  the mission tittle can get complex string as it will turn it to array such as HTML
//=========================================================================================
private ["_type","_string","_tittle","_dummyGroup","_dummy","_missionTittle","_missionInfo","_sidePlayer","_playMusic"];
_string 		= _this select 0;
_type 			= _this select 1;
_missionTittle 	= param [2, [], [[]]];;
_missionInfo	= param [3, [], [[]]];;
_sidePlayer =  _missionInfo param [7, sideLogic,[sideLogic]];
_playMusic = _missionInfo param [8, 0,[0]];

if !(isServer) exitWith {};

MCC_activeObjectives = [];
if (count _missionInfo > 0) then
{
	{
		if (count _x > 8) then
		{
			MCC_activeObjectives set [count MCC_activeObjectives, _x select 8]
		};
	} foreach (_missionInfo select 1);
};

if (typeName _type == "STRING") then
{
	_tittle = _type;
} else {
	_tittle = switch (_type) do
				{
				   case 0: {"Situation"};
				   case 1: {"Enemy Forces"};
				   case 2: {"Friendly Forces"};
				   case 3: {"Mission"};
				   case 4: {"Special Tasks"};
				   case 5: {"Fire Support"};
				};
};


waituntil {!isnil "MCC_server"};
_briefings = MCC_server getVariable ["briefings",[]];
_briefings pushBack [_tittle,_string];
MCC_server setVariable ["briefings",_briefings, true];

_dummyGroup = creategroup sidelogic;
_dummy = _dummyGroup createunit ["Logic", [0, 90, 90],[],0.5,"NONE"];	//Logic - placeHolder
waituntil {!isnull _dummy};

//Are we dealing with mission wizard's missions?
if (count _missionInfo > 0) then {
	_dummy setVariable ["missions",time,true];
	_dummy setVariable ["missionsInfo",_missionInfo,true];
	_dummy setVariable ["briefings",[_tittle, _string ,_missionTittle],true];
	_dummy setVariable ["objectives",MCC_activeObjectives ,true]; //---- Do we need that?!
};

//Start briefings
if (_playMusic in [0,1]) then {
	_init = format ["0 = _this spawn {if (!isDedicated && str playerSide == str %4) then {waituntil {alive player};player createDiaryRecord ['diary', ['%1',(toString %3) + '%2']];(_this getVariable 'missionsInfo') spawn MCC_fnc_MWopenBriefing;}};",_tittle, _string ,_missionTittle, _sidePlayer];

	[[[netid _dummy,_dummy], _init], "MCC_fnc_setVehicleInit", true, false] spawn BIS_fnc_MP;
};