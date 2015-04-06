//by Bon_Inf*
if(not isServer) exitWith{};

private ["_lasertarget"];

_requestor = _this select 0;
_side = _this select 1;

_cannons_to_fire = _requestor getVariable "requesting_cannons";
_cannons_available = _cannons_to_fire;
diag_log format["Cannon to fire: %1, Cannon avilable: %2",_cannons_to_fire, _cannons_available];	//debug

{//foreach _cannons_to_fire
	_available = MCC_server getVariable format["Arti_%2_Cannon%1_available",_x,_side];
	diag_log format["Acailable cannon: %1",_available];	//debug
	if(_available) then
	{
		_cannonsetup = _requestor getVariable format["Arti_%2_Cannon%1",_x,_side];
		MCC_server setVariable [format["Arti_%2_Cannon%1_available",_x,_side],false,true];

		[_x,_cannonsetup,_requestor,BON_salvo] spawn
		{
			private ["_cannon","_splashpos","_firedelay","_artitype","_nrshells","_spread","_salvo"];
			_cannon = _this select 0;
			_splashpos = (_this select 1) select 0;
			_firedelay = (_this select 1) select 1;
			_artitype = (_this select 1) select 2;
			_nrshells = (_this select 1) select 3;
			_spread = (_this select 1) select 4;
			_salvo = _this select 3;

			_requestor = _this select 2;
			_side = side _requestor;
			_requestor setVariable [format["Arti_%2_Cannon%1",_cannon,_side],nil,true];
			_requestor setVariable [format["Arti_%2_Cannon%1summary",_cannon,_side],nil,true];
			_shellsleft = MCC_server getVariable format["Arti_%1_shellsleft",_side];
			diag_log format["Cannon: %1,_splashpos: %2, _firedelay: %3, _artitype: %4, _nrshells: %5, _spread: %6, _requestor: %7, _shellsleft: %8",_cannon,_splashpos,_firedelay,_artitype,
							_nrshells,_spread,_requestor,_shellsleft];	//debug
			MCC_server setVariable [format["Arti_%1_shellsleft",_side],_shellsleft - _nrshells, true];

			sleep (5 + (random 5) + _firedelay);

			if (MCC_bonFire) then
				{
					MCC_bonFire = false;
					publicVariable "MCC_bonFire";
					[[[netid _requestor,_requestor], "shoutS5"], "MCC_fnc_globalSay3D", true, false] spawn BIS_fnc_MP;
					sleep 2;
					[[[netid _requestor,_requestor], "shoutO5"], "MCC_fnc_globalSay3D", true, false] spawn BIS_fnc_MP;
				};

			//MCC stuff
			for "_i" from 1 to _nrshells do
			{
				if (count MCC_bonCannons > 0) then
				{
					[2, [_cannon,_splashpos]] execVM MCC_path+"mcc\general_scripts\artillery\bon_art.sqf";
				};

				sleep 10;

				if (MCC_bonSplash) then
				{
					MCC_bonSplash = false;
					publicVariable "MCC_bonSplash";
					[[[netid _requestor,_requestor], "splashS6"], "MCC_fnc_globalSay3D", true, false] spawn BIS_fnc_MP;
					sleep 2;
					[[[netid _requestor,_requestor], "splashO6"], "MCC_fnc_globalSay3D", true, false] spawn BIS_fnc_MP;
				};

				_lasertarget = _requestor call arti_func_getLaser;

				if(_spread == 0 && isNull _lasertarget) exitWith {};
				if(_spread == 0) then
				{
					_splashpos = getPos _lasertarget;
				};

				switch (_artitype) do
					{
						case "GrenadeHand":	//HE DPICM
						{
							[_splashpos, _artitype, _spread, 1, true] spawn MCC_fnc_artyDPICM;
						};
						case "Smoke_120mm_AMOS_White":	//Smokeshell
						{
							[_splashpos, _artitype, _spread, 1, true] spawn MCC_fnc_artyFlare;
						};

						case "Smoke_82mm_AMOS_White":	//Smokeshell
						{
							[_splashpos, _artitype, _spread, 1, true] spawn MCC_fnc_artyFlare;
						};

						case "F_40mm_White":	//Flare White
						{
							[_splashpos, _artitype, _spread, 1, true] spawn MCC_fnc_artyFlare;
						};

						case "F_40mm_Green":	//Flare Green
						{
							[_splashpos, _artitype, _spread, 1, true] spawn MCC_fnc_artyFlare;
						};

						case "F_40mm_Red":	//Flare Red
						{
							[_splashpos, _artitype, _spread, 1, true] spawn MCC_fnc_artyFlare;
						};

						default	//bomb
						{
							[_splashpos, _artitype, _spread, 1, true] spawn MCC_fnc_artyBomb;
						};
					};

				sleep 5;
			};

			sleep (20 * _nrshells);
			MCC_server SetVariable [format["Arti_%2_Cannon%1_available",_cannon,_side],true,true];
		};
	}
	else {_cannons_available = _cannons_available - [_x]};
} foreach _cannons_to_fire;

for "_i" from 1 to HW_Arti_CannonNumber do
{
	if(not (_i in _cannons_to_fire)) then{
		_requestor setVariable [format["Arti_%2_Cannon%1",_i,_side],nil,true];
		_requestor setVariable [format["Arti_%2_Cannon%1summary",_i,_side],nil,true];
	};
};

if(true) exitWith
{
	_requestor setVariable ["requesting_cannons",nil,true];
	MCC_server setVariable [format["Arti_%1_requestor",_side],ObjNull,true];
};