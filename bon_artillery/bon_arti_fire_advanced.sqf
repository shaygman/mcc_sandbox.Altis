//by Bon_Inf*

if(not isServer) exitWith{};

private ['_lasertarget'];

_requestor = _this select 0;
_side = _this select 1;

_cannons_to_fire = _requestor getVariable "requesting_cannons";
_cannons_available = _cannons_to_fire;


{//foreach _cannons_to_fire
	_available = MCC_server getVariable format["Arti_%2_Cannon%1_available",_x,_side];
	if(_available) then{
		_cannonsetup = _requestor getVariable format["Arti_%2_Cannon%1",_x,_side];
		MCC_server setVariable [format["Arti_%2_Cannon%1_available",_x,_side],false,true];

		[_x,_cannonsetup,_requestor] spawn {
			_cannon = _this select 0;
			_splashpos = (_this select 1) select 0;
			_firedelay = (_this select 1) select 1;
			_artitype = (_this select 1) select 2;
			_nrshells = (_this select 1) select 3;
			_spread = (_this select 1) select 4;

			_requestor = _this select 2;
			_side = side _requestor;
			_requestor setVariable [format["Arti_%2_Cannon%1",_cannon,_side],nil,true];
			_requestor setVariable [format["Arti_%2_Cannon%1summary",_cannon,_side],nil,true];

			_shellsleft = MCC_server getVariable format["Arti_%1_shellsleft",_side];
			MCC_server setVariable [format["Arti_%1_shellsleft",_side],_shellsleft - _nrshells, true];

			sleep (15 + (random 5) + _firedelay);

			for "_i" from 1 to _nrshells do {

				_lasertarget = _requestor call arti_func_getLaser;
				if(_spread < 0 && isNull _lasertarget) exitWith{};
				if(_spread < 0) then{_splashpos = getPos _lasertarget};

/*******************************************************************************************************************/
/*******************************************************************************************************************/
/*******************************************************************************************************************/

				// for further work
				// code written here will be assigned to each cannon that was requested to fire and is available as such.

				// you have the following information:
				// "_splashpos" the 3d-position where artillery should go down
				// "_artitype" the type of artillery that is also defined in the "HW_arti_types" array in the bon_arti_init.sqf
				// "_spread" an integer representing the size of the area in meters that has to be covered by artillery







			// once finished replace the bon_arti_fire.sqf with this file


/*******************************************************************************************************************/
/*******************************************************************************************************************/
/*******************************************************************************************************************/
				sleep (7.5 + random 10);
			};

			sleep (30 * _nrshells);
			MCC_server SetVariable [format["Arti_%2_Cannon%1_available",_cannon,_side],true,true];
		};
	}
	else {_cannons_available = _cannons_available - [_x]};
} foreach _cannons_to_fire;

for "_i" from 1 to HW_Arti_CannonNumber do {
	if(not (_i in _cannons_to_fire)) then{
		_requestor setVariable [format["Arti_%2_Cannon%1",_i,_side],nil,true];
		_requestor setVariable [format["Arti_%2_Cannon%1summary",_i,_side],nil,true];
	};
};


if(true) exitWith{
	_requestor setVariable ["requesting_cannons",nil,true];
	MCC_server setVariable [format["Arti_%1_requestor",_side],ObjNull,true];
};