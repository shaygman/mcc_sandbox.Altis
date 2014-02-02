// F3 - Folk ARPS Clothes Gear Script
// Credits: Head

_isDiver = if ((paramsArray select 2) == 1) then {true} else {false};
_isSF = if ((paramsArray select 2) == 2) then {true} else {false};
// lets strip him down to the basic
removeUniform _unit;
removeheadgear _unit;
removevest _unit;

// use the type of the unit to figure out who gear they need
switch (_typeofUnit) do 
	{
		case "p":
		{
			// if there is a pilotuniform defeined add it to the unit
			if(!isnil "_pilotUniform" && _pilotUniform != "") then
			{
			_unit adduniform _pilotUniform;
			};
			// if there is ... etc.
			if(!isnil "_pilotHelmet" && _pilotHelmet != "") then
			{
			_unit addheadgear _pilotHelmet;
			};
			if(!isnil "_pilotRig" && _pilotRig != "") then
			{
			_unit addvest _pilotRig;
			};
		};
		case "div":
		{
			if(!isnil "_diverUniform" && _diverUniform != "") then
			{
			_unit adduniform _diverUniform;
			};
			if(!isnil "_diverHelmet" && _diverHelmet != "") then
			{
			_unit addheadgear _diverHelmet;
			};
			if(!isnil "_diverRig" && _diverRig != "") then
			{
			_unit addvest _diverRig;
			};
			
			_unit addGoggles "G_Diving";
		};
		case "eng":
		{
			if(!isnil "_baseUniform" && _baseUniform != "") then
			{
			_unit adduniform _lightUniform;
			};
			if(!isnil "_baseHelmet" ) then
			{
			_unit addheadgear _baseHelmet;
			};
			if(!isnil "_heavyRig" && _heavyRig != "") then
			{
			_unit addvest _heavyRig;
			};
		};
		case "ar":
		{
			if(!isnil "_baseUniform" && _baseUniform != "") then
			{
			_unit adduniform _lightUniform;
			};
			if(!isnil "_baseHelmet" ) then
			{
			_unit addheadgear _baseHelmet;
			};
			if(!isnil "_heavyRig" && _heavyRig != "") then
			{
			_unit addvest _heavyRig;
			};
		};
		case "mmgg":
		{
			if(!isnil "_baseUniform" && _baseUniform != "") then
			{
			_unit adduniform _baseUniform;
			};
			if(!isnil "_baseHelmet" ) then
			{
			_unit addheadgear _baseHelmet;
			};
			if(!isnil "_heavyRig" && _heavyRig != "") then
			{
			_unit addvest _heavyRig;
			};
		};
		case "m":
		{
			if(!isnil "_baseUniform" && _baseUniform != "") then
			{
			_unit adduniform _baseUniform;
			};
			if(!isnil "_baseHelmet" ) then
			{
			_unit addheadgear _baseHelmet ;
			};
			if(!isnil "_lightRig" && _lightRig != "") then
			{
			_unit addvest _lightRig;
			};
		};
		case "dc":
		{
			if(!isnil "_baseUniform" && _baseUniform != "") then
			{
			_unit adduniform _baseUniform;
			};
			if(!isnil "_baseHelmet" ) then
			{
			_unit addheadgear _baseHelmet ;
			};
			if(!isnil "_lightRig" && _lightRig != "") then
			{
			_unit addvest _lightRig;
			};
		};
		//===========================SF========================================
		case "sftl":
		{
			if(!isnil "_SFlightUniform" && _SFlightUniform != "") then
			{
			_unit adduniform _SFlightUniform;
			};
			if(!isnil "_SFlightHelmet" ) then
			{
			_unit addheadgear _SFlightHelmet ;
			};
			if(!isnil "_SFheavyRig" && _SFheavyRig != "") then
			{
			_unit addvest _SFheavyRig;
			};
			removeGoggles _unit;
			_unit addGoggles "G_Tactical_Clear";
		};
		case "smrk":
		{
			if(!isnil "_SFlightUniform" && _SFlightUniform != "") then
			{
			_unit adduniform _SFlightUniform;
			};
			if(!isnil "_lightHelmet" ) then
			{
			_unit addheadgear "H_Shemag_olive" ;
			};
			if(!isnil "_SFlightRig" && _SFlightRig != "") then
			{
			_unit addvest _SFlightRig;
			};
			removeGoggles _unit;
			_unit addGoggles "G_Tactical_Clear";
		};
		case "smmgg":
		{
			if(!isnil "_SFlightUniform" && _SFlightUniform != "") then
			{
			_unit adduniform _SFlightUniform;
			};
			if(!isnil "_SFbaseHelmet" ) then
			{
			_unit addheadgear _SFbaseHelmet ;
			};
			if(!isnil "_SFheavyRig" && _SFheavyRig != "") then
			{
			_unit addvest _SFheavyRig;
			};
			removeGoggles _unit;
			_unit addGoggles "G_Tactical_Clear";
		};
		
		case "sr":
		{
			if(!isnil "_SFbaseUniform" && _SFbaseUniform != "") then
			{
			_unit adduniform _SFbaseUniform;
			};
			if(!isnil "_SFbaseHelmet" ) then
			{
			_unit addheadgear _SFbaseHelmet ;
			};
			if(!isnil "_SFlightRig" && _SFlightRig != "") then
			{
			_unit addvest _SFlightRig;
			};
			removeGoggles _unit;
			_unit addGoggles "G_Tactical_Clear";
		};
		
		case "sexp":
		{
			if(!isnil "_SFbaseUniform" && _SFbaseUniform != "") then
			{
			_unit adduniform _SFbaseUniform;
			};
			if(!isnil "_lightHelmet" ) then
			{
			_unit addheadgear "H_Watchcap_khk" ;
			};
			if(!isnil "_SFheavyRig" && _SFheavyRig != "") then
			{
			_unit addvest _SFheavyRig;
			};
			removeGoggles _unit;
			_unit addGoggles "G_Tactical_Clear";
		};
		
		case "smed":
		{
			if(!isnil "_SFlightUniform" && _SFlightUniform != "") then
			{
			_unit adduniform _SFlightUniform;
			};
			if(!isnil "_SFbaseHelmet" ) then
			{
			_unit addheadgear _SFbaseHelmet ;
			};
			if(!isnil "_SFlightRig" && _SFlightRig != "") then
			{
			_unit addvest _SFlightRig;
			};
			removeGoggles _unit;
			_unit addGoggles "G_Tactical_Clear";
		};
		
		case "sn":
		{
			if(!isnil "_sfUniform" && _sfUniform != "") then
			{
			_unit adduniform _sfUniform;
			};
			if(!isnil "_sfHelmet" ) then
			{
			_unit addheadgear _sfHelmet ;
			};
			if(!isnil "_sfRig" && _sfRig != "") then
			{
			_unit addvest _sfRig;
			};
			removeGoggles _unit;
			_unit addGoggles "G_Tactical_Clear";
		};
		
		case "sp":
		{
			if(!isnil "_sfUniform" && _sfUniform != "") then
			{
			_unit adduniform _sfUniform;
			};
			if(!isnil "_sfHelmet" ) then
			{
			_unit addheadgear _sfHelmet ;
			};
			if(!isnil "_sfRig" && _sfRig != "") then
			{
			_unit addvest _sfRig;
			};
			removeGoggles _unit;
			_unit addGoggles "G_Tactical_Clear";
		};
		
		case "cr":
		{
			if(!isnil "_crewUniform" && _crewUniform != "") then
			{
			_unit adduniform _crewUniform;
			};
			if(!isnil "_crewHelmet" ) then
			{
			_unit addheadgear _crewHelmet ;
			};
			if(!isnil "_crewRig" && _crewRig != "") then
			{
			_unit addvest _crewRig;
			};
		};
		
		default
		{
			if(!isnil "_baseUniform" && _baseUniform != "") then
			{
			_unit adduniform _baseUniform;
			};
			if(!isnil "_baseHelmet" ) then
			{
			_unit addheadgear _baseHelmet;
			};
			if(!isnil "_lightRig" && _lightRig != "") then
			{
			_unit addvest _lightRig;
			};
		};
	};
	
if ((_typeofUnit in ["sftl","smrk","smmgg","sr","sexp","smed"]) && _isDiver) then {
			if(!isnil "_diverUniform" && _diverUniform != "") then
			{
			_unit adduniform _diverUniform;
			};
			if(!isnil "_diverHelmet" && _diverHelmet != "") then
			{
			_unit addheadgear _diverHelmet;
			};
			if(!isnil "_diverRig" && _diverRig != "") then
			{
			_unit addvest _diverRig;
			};
			 removeGoggles _unit;
			_unit addGoggles "G_Diving";
	};
	
if ((_typeofUnit in ["sftl","smrk","smmgg","sr","sexp","smed"]) && _isSF) then {
			if(!isnil "_sfUniform" && _sfUniform != "") then
			{
			_unit adduniform _sfUniform;
			};
			if(!isnil "_sfHelmet" && _sfHelmet != "") then
			{
			_unit addheadgear _sfHelmet;
			};
			if(!isnil "_sfRig" && _sfRig != "") then
			{
			_unit addvest _sfRig;
			};
	};