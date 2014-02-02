//Made by Shay_Gman (c) 09.10
private ["_trapkind", "_iedMarkerName", "_fakeIed","_zoneX","_zoneY","_startingPos","_visable",
		"_mcc_zone_pos","_mcc_zone_size","_mineClass","_minePos"]; 

_trapkind = _this select 0; 
_iedMarkerName = _this select 1;
_mcc_zone_pos = _this select 2;
_mcc_zone_size = _this select 3;
_startingPos = []; 

if (_trapkind=="apv") then {_mineClass ="APERSMine"; _visable = true;};
if (_trapkind=="ap") then {_mineClass ="APERSMine"; _visable = false;};
if (_trapkind=="apbv") then {_mineClass ="APERSBoundingMine"; _visable = true;};
if (_trapkind=="apb") then {_mineClass ="APERSBoundingMine"; _visable = false;};
if (_trapkind=="atv") then {_mineClass ="ATMine"; _visable = true;};
if (_trapkind=="at") then {_mineClass ="ATMine"; _visable = false;};

_zoneX = _mcc_zone_size select 0;
_zoneY = _mcc_zone_size select 1;
_startingPos = [((_mcc_zone_pos select 0) -_zoneX), ((_mcc_zone_pos select 1) - _zoneY),0];
for [{_i=0},{_i<=(_zoneX*2)},{_i=_i+10}] do 
	{
	for [{_x=1},{_x<=(_zoneY*2)},{_x=_x+10}] do 
		{
		_minePos = [((_startingPos select 0) + (_i - 2) + random 4),((_startingPos select 1) + (_x - 2) + random 4)];
		if (_visable && (random 5 <0.7)) then {
			_fakeIed = "Land_Sign_Mines_F" createvehicle[((_startingPos select 0) + (_i - 2) + random 4),((_startingPos select 1) + (_x - 2) + random 4),(_startingPos select 2) - 0.06];
			} else {
				_fakeIed = createMine [_mineClass ,_minePos,[],0];
				};
		};
	};
	