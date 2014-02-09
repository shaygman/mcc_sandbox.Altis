//==================================================================fnc_DoInfPatrol===============================================================================================
// Generate some stuff to do for our attack
// Example: [_group,_targetpos] call fnc_DoAttackInf
// spirit 20-1-2014
//===========================================================================================================================================================================	
private ["_group","_TargetPos","_pos","_Degree","_NrOfBuildingWp"];

_group 			= _this select 0; 
_TargetPos	=	_this select 1;

_Pos 			= (position leader _group);
_CoverPos	= [];
_NrOfBuildingWp = 0;
_Degree = 0;
_angle  = [42,0,-42] call BIS_fnc_selectRandom;


[_group] call fnc_RemoveWayPoints;


if !(surfaceiswater _TargetPos ) then
	{
		//Set the recon unit in stealth
		_group  setBehaviour	"STEALTH";
		
		while {(_Pos distance _TargetPos)>200} do
		{
			sleep 0.1;
			//Determine our compass heading from group leader to _TargetPos
			_Degree=[_Pos, _TargetPos] call BIS_fnc_dirTo;
			//With a -30 to + 30 degree difference do move 100 to TargetPos
			_pos		=[_Pos, (((_Pos distance _TargetPos)/2) max 100),(_Degree-(_Angle)) ] call BIS_fnc_relPos;		
			//And please, please, please, try some cover ok.Within 50, so another wild flanking thingy
			_CoverPos	= [];
			_CoverPos =selectBestPlaces [_pos, 30, "forest+trees+2*hills+houses", 1, 1];
			//We found some good stuf, go use it
			if ((count (_CoverPos))>0) then
				{
					_CoverPos=(_CoverPos select 0 select 0);
					_pos = _CoverPos;
				};
			if !(surfaceiswater _pos ) then
				{
				//Give the dude an Attack Waypoint
				_dummy	=[_group,_pos, "MOVE"] call fnc_AddAttackWaypoint;
				};
			
		};	
		
		
		
		
		_dummy	=[_group,_TargetPos, "SAD"] call fnc_AddAttackWaypoint;
		//_NrOfBuildingWp 	 = [_group]call fnc_CreateBuildingWP;
		
		
	};
	

((count (waypoints _group)) - currentWaypoint _group)



