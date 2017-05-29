/*============================================================MCC_fnc_ambientFireInit=======================================================================
Starts a Init ambient fire - MUST RUN ON SERVER
	<IN>
		Nothing

	<OUT>
		Nothing
==============================================================================================================================================================*/
//If we came here from Zeus run on the server
if (!isnull curatorcamera) then {
	_str = "<t size='0.8' t font = 'puristaLight' color='#FFFFFF'>" + "Ambient Fire Enabled" + "</t>";
	_null = [_str,0,1.1,2,0.1,0.0] spawn bis_fnc_dynamictext;
	if (!isServer) then {[] remoteExec ["MCC_fnc_ambientFireInit", 2]};
	deleteVehicle (param [0,objNull,[objNull]]);
};

if  (!isServer || (missionNamespace getVariable ["MCC_ambientFireInit",false])) exitWith {};
missionNamespace setVariable ["MCC_ambientFireInit",true];
publicVariable "MCC_ambientFireInit";

//Start the fun
missionNamespace setVariable ["MCC_ambientFire",true];
publicVariable "MCC_ambientFire";

//Add vehicle on fire EH
MCC_fnc_ambientFireEntityKilled = {
	private ["_vehicle","_crewBurning"];
	_vehicle = param [0,objNull,[objNull]];

	if ((_vehicle isKindOf "Landvehicle") or (_vehicle isKindOf "Air")) then {

		//Get vehicle crew
		_crewBurning = [];
		{
			if (random 1 < 0.2 && !isPlayer _x) then {
				_crewBurning pushBack (typeof _x);
				deleteVehicle _x;
			};
		} forEach (crew _vehicle);

		waituntil {isTouchingGround _vehicle};

		{
			sleep 2 + (random 3);

			[_x,_vehicle] spawn {
				#define	FIRE_OBJECTSMALL	"IncinerateShell"
				#define	FIRE_OBJECTBIG	"test_EmptyObjectForFireBig"

				params ["_class","_vehicle"];
				private ["_unit","_pos","_effect","_group","_dir","_time"];

				_dir = if (random 1 > 0.5) then {(direction _vehicle)-(70 + random 40)} else {(direction _vehicle)+(70 + random 40)};
				_pos =  [(getpos _vehicle),3,_dir] call BIS_fnc_relPos;

				if (_pos isEqualTo []) exitWith {};


				_group = createGroup ([(getNumber(configFile >> "cfgVehicles" >> _class >> "side"))] call BIS_fnc_sideType);
				//_unit = createAgent [_class, _pos, [], 0, "FORM"];
				_unit = _group createUnit [_class, _pos, [], 0, "NONE"];
				_unit disableAI "ALL";
		        _unit allowDamage false;
		        removeAllWeapons _unit;
				_unit switchMove "";
				_unit setdir _dir;
				_effect = FIRE_OBJECTBIG createVehicle [0,0,0];
		        _effect attachTo [_unit,[0,0,-1]];

				_unit setpos _pos;

				_unit doMove (_unit modelToWorld [0,50,0]);
				_unit playmovenow "ApanPknlMsprSnonWnonDf";
				_time = time + (3 + (random 2));
				while {time < _time} do	{
					[_unit,format ["MCC_manScream_%1",(floor (random 7))+1],"say3d"] remoteExec ["bis_fnc_sayMessage", 0];
					sleep 1 + (random 1);
				};

				_unit setDamage 1;
				deleteGroup _group;

				//Start a new fire center
				[_unit] spawn MCC_fnc_ambientFireStart;


				//Delte fire
				sleep 20 + random 30;
				while {!isnull (attachedTo _effect)} do {detach _effect};
				_nearObjects =  (getpos _effect) nearObjects 5;
				{
					if (typeOf _x in [FIRE_OBJECTBIG,"#particlesource","#lightpoint"]) then {deletevehicle _x};
				} foreach _nearObjects;
			};
		} forEach _crewBurning;

		sleep 5 + (random 10);
		_pos = getpos _vehicle;

		if !(surfaceIsWater _pos) then {
			[_pos] spawn MCC_fnc_ambientFireStart;
		};
	};
};

if ((missionNamespace getVariable ["MCC_fnc_ambientFireInitEH",-1]) <=0) then {
	_id = addMissionEventHandler ["EntityKilled",{ if (missionNamespace getVariable ["MCC_ambientFire",false]) then {[(_this select 0)] spawn MCC_fnc_ambientFireEntityKilled}}];

	missionNamespace setVariable ["MCC_fnc_ambientFireInitEH",_id];
};


//Add explosive rounds fire
[] remoteExec ["MCC_fnc_ambientFirePlayerFiredEH",0];