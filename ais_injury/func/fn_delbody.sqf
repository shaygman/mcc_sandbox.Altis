// by psycho
_body = _this select 0;
_delay = _this select 1;

if (_delay <= 0) exitWith {};
sleep (_delay + (random 20));

deleteVehicle _body;