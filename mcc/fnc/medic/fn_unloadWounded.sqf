//=================================================================MCC_fnc_loadWounded========================================================================================
//Load wounded to a vehicle
//=============================================================================================================================================================================
private ["_suspect","_ctrlData","_load"];
_suspect 	= _this select 0;
_ctrlData 	= _this select 1;
_load 		= _this select 2;

if (_load) then
{
	if (_suspect getVariable ["MCC_medicUnconscious",false] && alive _suspect) then
	{
		_number = call compile ([_ctrlData, "0123456789"] call BIS_fnc_filterString);
		_nearVehicles = [];
		if (_suspect getVariable ["MCC_medicUnconscious",false]) then
		{
			_nearVehicles = (_suspect nearObjects ["Helicopter",5]) + (_suspect nearObjects ["LandVehicle",5]);

			for [{_x=0},{_x<count _nearVehicles},{_x=_x+1}] do
			{
				_vehicle = _nearVehicles select _x;
				if ((_vehicle emptyPositions "cargo")==0 || ((vectorUp _vehicle) select 2) <=0 || locked _vehicle >1) then {_nearVehicles set [_x,-1]};
			};

			_nearVehicles = _nearVehicles - [-1];
		};

		if (count _nearVehicles <= _number) exitWIth {};
		_vehicle = _nearVehicles select _number;
		_suspect moveInCargo _vehicle;
		_suspect assignAsCargo _vehicle;
		_t = time +5;
		waituntil {time > _t || vehicle _suspect != _suspect};
		_suspect playmoveNow "Unconscious";
	};
};