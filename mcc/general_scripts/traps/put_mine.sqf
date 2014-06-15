//Made by Shay_Gman (c) 09.10
private ["_trapkind", "_iedMarkerName", "_fakeIed","_zoneX","_zoneY","_startingPos","_visable",
		"_mcc_zone_pos","_mcc_zone_size","_mineClass","_minePos"]; 

_trapkind = _this select 0; 
_iedMarkerName = _this select 1;
_mcc_zone_pos = _this select 2;
_mcc_zone_size = _this select 3;
_startingPos = []; 

switch (_trapkind) do
{
	case "apv": 
	{
		_mineClass ="ModuleMine_APERSMine_F"; 
		_visable = true;
	};
	
	case "ap": 
	{
		_mineClass ="ModuleMine_APERSMine_F"; 
		_visable = false;
	};
	
	case "apbv": 
	{
		_mineClass ="ModuleMine_APERSBoundingMine_F"; 
		_visable = true;
	};
	
	case "apb": 
	{
		_mineClass ="ModuleMine_APERSBoundingMine_F"; 
		_visable = false;
	};
	
	case "atv": 
	{
		_mineClass ="ModuleMine_ATMine_F"; 
		_visable = true;
	};
	
	case "at": 
	{
		_mineClass ="ModuleMine_ATMine_F"; 
		_visable = false;
	};
	
	case "nvm": 
	{
		_mineClass ="ModuleMine_UnderwaterMine_F"; 
		_visable = false;
	};
	
	case "nv": 
	{
		_mineClass ="ModuleMine_UnderwaterMineAB_F"; 
		_visable = false;
	};
	
	case "pdm": 
	{
		_mineClass ="ModuleMine_UnderwaterMinePDM_F"; 
		_visable = false;
	};
};


_zoneX = _mcc_zone_size select 0;
_zoneY = _mcc_zone_size select 1;

_startingPos = [((_mcc_zone_pos select 0) -_zoneX), ((_mcc_zone_pos select 1) - _zoneY),0];

for [{_i=0},{_i<=(_zoneX*2)},{_i=_i+30}] do 
{
	for [{_x=1},{_x<=(_zoneY*2)},{_x=_x+30}] do 
	{
		_minePos = [((_startingPos select 0) + (_i - 2) + random 4),((_startingPos select 1) + (_x - 2) + random 4)];
		if (_visable && (random 5 <0.7)) then 
		{
			_fakeIed = "Land_Sign_Mines_F" createvehicle[((_startingPos select 0) + (_i - 2) + random 4),((_startingPos select 1) + (_x - 2) + random 4),(_startingPos select 2) - 0.06];
		} 
		else 
		{
			_fakeIed = createvehicle [_mineClass ,_minePos,[],0,"none"];
		};
		
		MCC_curator addCuratorEditableObjects [[_fakeIed],false]; 
	};
};
	