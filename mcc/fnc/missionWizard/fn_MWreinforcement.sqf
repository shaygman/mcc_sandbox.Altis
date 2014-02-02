//======================================================MCC_fnc_MWreinforcement=========================================================================================================
// Create a reinforcment type
// Example:[_reinforcement,_side, _missionCenterTriggerPos,_missionCenterTriggerArea,_cond] call MCC_fnc_MWreinforcement; 
//
//	<IN>	
//	_reinforcement: 			Integer, 1 - Aerial, 2 - Motorized, 3 - Mixed
// 	_side: 					side, reinforcment's side
// 	_missionCenterTriggerPos: 	Array, Center Position
//	_missionCenterTriggerArea	Trigger Area as in  [H, W, angle, rectangle (boolead)].
// 	_cond: 					Array of conditions when the number of units at the start are less in precentage then the number in condition a reinforcment will occur. 
//
// 	<OUT>
//			Nothing
//========================================================================================================================================================================================
private ["_reinforcement","_side","_missionCenterTriggerPos","_missionCenterTriggerArea","_cond","_trigger","_tlist","_zoneNumber","_script_handler","_found",
         "_faction","_warning","_ar","_totalEnemyUnits","_size","_strDir","_command","_para"];
		 
_reinforcement 				= _this select 0;
_side 						= _this select 1;
_missionCenterTriggerPos 	= _this select 2;
_missionCenterTriggerArea 	= _this select 3;
_cond					 	= _this select 4;
_zoneNumber					= _this select 5;
_faction					= _this select 6;
_warning					= _this select 7;
_totalEnemyUnits			= _this select 8;


if !(isServer || isDedicated) exitWith {};

//Size: 0 - small, 1 - medium, 2 - large
_size = 0;	
if (_totalEnemyUnits > 40) then {_size = 1};
if (_totalEnemyUnits > 60) then {_size = 2};

_trigger = createTrigger ["emptydetector",_missionCenterTriggerPos]; 
_trigger settriggerarea _missionCenterTriggerArea;
_trigger setTriggerActivation [str _side, "PRESENT", true];
sleep 5;
_tlist = (_side countSide (list _trigger)); 

private ["_dir","_distance","_newPos","_script_handler","_rfc"];



for "_i" from 0 to (count _cond) step 1 do 
{
	//Create Zone
	_found = false; 
	
	_rfc = if (_reinforcement == 3) then {[1,2] call BIS_fnc_selectRandom} else {_reinforcement}; 
	if (_rfc == 2 && (count MCC_MWunitsArrayCar) <= 0) then {_rfc = 1};
	
	while {!_found} do
	{
		_dir = floor random 360;
		_distance = (floor (random 1000)) + (if (_rfc == 0) then {2000} else {1000}); 
		_newPos = [_missionCenterTriggerPos, _distance, _dir] call BIS_fnc_relPos;
		_newPos = getposATL ((_newPos nearRoads 200) select 0);
		if (!isNil "_newPos") then
		{
			_found = true;
			{
				if (isPlayer _x && (_x distance _newPos < 1000)) then {_found = false};
			} forEach allUnits; 
		};
	};
	
	while {(1-(_side countSide (list _trigger))/_tlist) < (_cond select _i)} do {sleep 10};
	
	switch (_rfc) do	
	{
		case 1: 	//Aerial
		{
			//Size
			switch (_size) do
			{
				case 0:
				{
					_para = [0,0,1,3,3,4,6,6,7] call BIS_fnc_selectRandom; 
				};
				
				case 1:
				{
					_para = [1,1,2,4,4,5,7,7,8] call BIS_fnc_selectRandom; 
				};
				
				case 2:
				{
					_para = [1,2,2,4,5,5,7,8,8] call BIS_fnc_selectRandom;  
				};
			};
			
			if (_warning) then
			{
				//Lets give the player some hint about movment
				_dir 	= [_missionCenterTriggerPos, _newPos] call BIS_fnc_dirTo;
				_strDir = "<t size='1' t font = 'puristaLight' color='#FFFFFF'> HQ: Enemy QRF helicopter is moving in from the " + ([_dir] call MCC_fnc_dirToString) + "</t>";
				_command = format ['["%1",0,0.2,5,1,0.0] spawn bis_fnc_dynamictext;',_strDir];
				[[2,compile _command], "MCC_fnc_globalExecute", true, false] spawn BIS_fnc_MP;
			};
		};
		
		case 2: 	//Motorized
		{
			_para = _size + 9; 
			if (_warning) then
			{
				//Lets give the player some hint about movment
				_dir 	= [_missionCenterTriggerPos, _newPos] call BIS_fnc_dirTo;
				_strDir = "<t size='1' t font = 'puristaLight' color='#FFFFFF'> HQ: Enemy QRF convoy is moving in from the " + ([_dir] call MCC_fnc_dirToString) + "</t>";
				_command = format ['["%1",0,0.2,5,1,0.0] spawn bis_fnc_dynamictext;',_strDir];
				[[2,compile _command], "MCC_fnc_globalExecute", true, false] spawn BIS_fnc_MP;
			};
			
		};
	};
	
	//spawn
	_ar =	[ "Reinforcement"
			, _para
			, false
			, true
			, _para
			, _faction
			, _zoneNumber
			, "NOTHING"
			, str _zoneNumber
			, "MOVE"
			, _missionCenterTriggerPos
			, [_missionCenterTriggerArea select 0,_missionCenterTriggerArea select 1]
			, _missionCenterTriggerArea select 0
			, str _side
			, server
			, 0
			, false
			, false
			, mcc_missionmaker
			, "default"
			, 0
			, _newPos
			, 0 //(mcc_zonetype select 0 ) select 1
			, 0 //(mcc_zonetypenr select 0 ) select 1
			, 0
			];
			
	[_ar, "mcc_setup", false, false] spawn BIS_fnc_MP;
};
	
//Clean up
deleteVehicle _trigger;
