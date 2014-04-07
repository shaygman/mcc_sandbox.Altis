private ["_cannon","_type","_dummypos"];
_type = _this select 0;

switch (_type)  do {
		case 0: {
			_cannon = _this select 1;
			_dummypos = [getpos _cannon, 50, getdir _cannon] call BIS_fnc_relPos;
			(gunner _cannon) lookAt [_dummypos select 0, _dummypos select 1,(_dummypos select 2)+100];
			MCC_bonCannons set [count MCC_bonCannons, _cannon];
			publicvariable "MCC_bonCannons";
			
			HW_Arti_CannonNumber = if (count MCC_bonCannons== 0) then {5} else {count MCC_bonCannons};
			publicvariable "HW_Arti_CannonNumber";
		};
		case 1: {
			_cannon = MCC_bonCannons select ((_this select 1) select 0)-1;
			_dummypos = (_this select 1) select 1;
			_cannon addeventhandler["fired", {_null =[4,_this select 0, _this select 4] spawn MCC_fnc_amb_Art}]; //Delete the projectile.
			(gunner _cannon) lookAt [_dummypos select 0, _dummypos select 1,(_dummypos select 2)+1000];
			_cannon disableAI "AUTOTARGET";
			_cannon disableAI "TARGET";
		};
		case 2: {
			_cannon = MCC_bonCannons select ((_this select 1) select 0)-1;
			_dummypos = (_this select 1) select 1;
			_cannon fire (weapons _cannon select 0);
			_cannon setVehicleAmmo 1;
		};
	};