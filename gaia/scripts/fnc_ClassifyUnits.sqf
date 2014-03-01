/*
babba= [units group player] call fnc_countgroup;abba = [units group player] call fnc_gaia_Classifygroup; cabba = [vehicle player] call fnc_countunit;
*/
//==================================================================MCC_fnc_countGroup===============================================================================================
// 
//
//
//===========================================================================================================================================================================	
private ["_units","_class"];

_units 			= _this select 0; 
_class			= "";


//[_infantryCount,_vehicleCount,_tankCount,_artilleryCount,_airCount,_shipCount,_reconCount,_supportCount,_autonomousCount,_staticCount,_submarineCount
//,[_CarClass,_tankClass,_artilleryClass,_airClass,_boatClass,_supportClass,_autonomousClass]
//,[_at,_aal,_aah]];
_Assets = [_units] call fnc_CountUnitTypes;

_infantryCount 		= _Assets select 0;
_reconCount				=	_Assets select 6;
_CarCount	 				= _Assets select 1;
_tankCount		 		= _Assets select 2;
_artilleryCount 	= _Assets select 3;
_airCount				 	= _Assets select 4;
_shipCount				= _Assets select 5;
_supportCount			=	_Assets select 7;
_autonomousCount	= _Assets select 8;
_staticCount			=	_Assets select 9;
_submarineCount		=	_Assets select 10;
_AACount					=	_Assets select 11;
_CargoCount				=	_Assets select 12;
_MortarCount			=	_Assets select 13;

//What is the total shit we got
_totalCount				= _infantryCount+_CarCount+_tankCount+_artilleryCount+_airCount+_shipCount+_reconCount+_supportCount+_autonomousCount+_staticCount+_submarineCount+_AACount+_mortarcount;

//We have enough cargo for all units? Important to load / unload shit and affects the speed.
_EnoughCargo 			= (_cargocount >= (_infantryCount+_reconCount));

//Do the vehicles have gun? Affects points and also the possible portfolio of commands
_NrOfVehicleGuns  = 0;

_DoClear 			= ['DoClear'];
_DoPatrol			= ['DoPatrol'];
_DoRecon			= ['DoRecon'];
_DoAttack			=	['DoAttack'];
_DoHide				= ['DoHide'];
_DoMortar			=	['DoMortar'];
_DoArtillery	=	['DoArtillery'];
_DoTransport	= ['DoTransport'];
_DoCAS				= ['DoCAS'];
_DoSupport		= ['DoSupport'];
_DoGuard			=	['DoGuard'];
_DoPark				= ['DoPark'];
_DoWait				= ['DoWait'];


_portfolio		= [];

//For the sake of humanity, check the guns of the vehicle,
//How many times have we seen empty jeeps charge the field?
{
	if (count(_x) > 0) then
	{
		{
			_NrOfVehicleGuns = _NrOfVehicleGuns + (_x select 2);
		} forEach (_x);
	};	
} forEach (_assets select 14);
_VehicleHasGuns = (_NrOfVehicleGuns>0);



_points = 0;
if (_totalCount >0)  then
{
		//This is the most basic point system ever. At a later version we go checkout if a car is more then just a car -> weapons, at etc. For now, this is it.
		_points						=(_infantryCount * 2)
											+(_CarCount *5)
											+(_tankCount *10)
											+(_artilleryCount * 5)
											+(_airCount * 20)
											+(_shipCount * 10)
											+(_reconCount * 3)
											+(_supportCount * 1)
											+(_autonomousCount * 0)
											+(_staticCount * 4)
											+(_submarineCount * 0)
											+(_AACount * 5)
											+(_Mortarcount * 5)
											+(_NrOfVehicleGuns * 5);
};									
//The default speed
				_speed													= "SLOW";

//The class system is far from ready. But it is a first shot, not even half of the conclusions from the above are in there.
switch(true)do
{
		
		//Infantry
		case (_infantryCount ==  _totalCount): 
			{
				_class 													= "Infantry";
				//_speed												= "SLOW";
				_portfolio = _portfolio					+ _DoClear;
				_portfolio = _portfolio					+ _DoAttack;
				_portfolio = _portfolio					+ _DoPatrol;
			};
			
		//Recon infantry
		case (_reconCount				 				==  _totalCount): 
			{
					_class = "ReconInfantry";
					_portfolio = _portfolio					+ _DoClear;
					_portfolio = _portfolio					+ _DoAttack;
					_portfolio = _portfolio					+ _DoPatrol;
			};
			
		//Mixed infantry -> Infantry
		case (_reconCount+_infantryCount	==  _totalCount): 
			{
					_class 													= "Infantry";
					_portfolio = _portfolio					+ _DoClear;
					_portfolio = _portfolio					+ _DoAttack;
					_portfolio = _portfolio					+ _DoPatrol;
			};
	
		// Mortar
		case (_Mortarcount	==  _totalCount): 
			{
					_class 													= "Mortar";					
					_portfolio = _portfolio					+ _DoMortar;					
			};		
			
		//AA  If we holde infantry, recon, vehicles then we consider it guards.
		case ((_AACount > 0)and (_tankCount==0)): 
			{
				_class 													= "AA";
				if (_EnoughCargo) then {_speed 	= "MEDIUM";}; 
				_portfolio = _portfolio					+ _DoHide;
			};			
			
		//Car
		case (_CarCount	==  _totalCount): 
			{
				_class 													= "Car";
				if (_EnoughCargo) then {_speed 	= "MEDIUM";}; 
				
				
				
				//No guns but do hold space? We are a transporter
				if (!_VehicleHasGuns and _EnoughCargo ) then
				{
				_portfolio = _portfolio					+ _DoTransport;				
				_portfolio = _portfolio					+ _DoPark;				
				};
				
				//Please, for the love of god check if we have guns before we charge in.
				if (_VehicleHasGuns) then
				{
				_portfolio = _portfolio					+ _DoAttack;
				_portfolio = _portfolio					+ _DoPatrol;
				
				};
			};
			
			//Motorized Recon		
		case (_CarCount+_reconCount	==  _totalCount) : 
			{
				_class = "MotorizedRecon";
				if (_EnoughCargo) then {_speed 	= "MEDIUM";}; 
				_portfolio = _portfolio					+ _DoPatrol;
				_portfolio = _portfolio					+ _DoAttack;
				
			};		
				
		//Motorized Infantry
		case ((_CarCount+_infantryCount+ _reconCount	==  _totalCount)) : 
			{
				_class = "MotorizedInfantry";
				if (_EnoughCargo) then {_speed 	= "MEDIUM";}; 
				_portfolio = _portfolio					+ _DoPatrol;
				_portfolio = _portfolio					+ _DoAttack;
				
			};		
			
		// Tanky Spanky. Also mixed with mobile AA is considered a TANK group. As soon as they loose their tanks -> AA
		case (_tankCount+_AACount	 						==  _totalCount): 
			{
				_class = "Tank";
				if (_EnoughCargo) then {_speed 	= "MEDIUM";}; 
				//For now i dont want tanks to patrol. Do needs a better option in a later version.
				_portfolio = _portfolio					+ _DoHide;
				
				//If we failed to see our tank class but it holds no guns, then please dont let it attack.
				if (_VehicleHasGuns) then				
				{
				_portfolio = _portfolio					+ _DoAttack;
				
				};
				
				//For now set on 5. I think just a few seats wont make it a transporter.
				if (_CargoCount>5) then				
				{
				_portfolio = _portfolio					+ _DoTransport;
				
				};
				
			};
			
		//Mechanized inf (we dont acknowledge recon 
		case (_tankCount+_infantryCount+ _reconCount ==  _totalCount) : 
			{
				_class = "MechanizedInfantry";
				if (_EnoughCargo) then {_speed 	= "MEDIUM";}; 
				_portfolio = _portfolio					+ _DoPatrol;
				_portfolio = _portfolio					+ _DoAttack;
				
			};			
			
		//If there is ARtillery, there is artillery. Rest is guard, but the group behaves like arty
		case (_artilleryCount		 				>	  0): 
			{	
				_class = "Artillery";				
				if (_EnoughCargo) then {_speed 	= "MEDIUM";}; 
				_portfolio = _portfolio					+ _DoHide;				
				_portfolio = _portfolio					+ _DoArtillery;
			};
			
		
		//This conclusion is incorrect, but sufficient for first release. We handle planes and jets in next release.
		case (_airCount					 				==  _totalCount): 
			{
				_class = "Helicopter";
				_speed													= "FAST";
				_portfolio = _portfolio					+ _DoWait;
				
				
				//No guns but do hold space? We are a transporter

				if (!_VehicleHasGuns and _EnoughCargo ) then
				{
				
				_portfolio = _portfolio					+_DoPatrol;				
				};
				
				//Please, for the love of god check if we have guns before we charge in.
				if (_VehicleHasGuns) then
				{
				_portfolio = _portfolio					+ _DoAttack;
				
				
				};
			};
			
		//Ship
		case (_shipCount				 				==  _totalCount): 
			{
				
				_class = "Ship";
				_speed													= "MEDIUM";
				
				_portfolio = _portfolio					+ _DoPatrol;
				//It speaks for itself that they only Do Attack and Do Clear water locations.
				if (_VehicleHasGuns) then
				{
				_portfolio = _portfolio					+ _DoAttack;
				_portfolio = _portfolio					+ _DoClear;
				};
			};
			

			
		//Motorized Recon		
		case ((_CarCount+_reconCount	==  _totalCount) and (_CarCount>0) and (_reconCount>0)) : 
			{
				_class = "MotorizedInfantry";
				if (_EnoughCargo) then {_speed 	= "MEDIUM";}; 
				_portfolio = _portfolio					+ _DoPatrol;
				_portfolio = _portfolio					+ _DoAttack;
				_portfolio = _portfolio					+ _DoClear;
			};		
			
		//We have a support unit? Then the whole group is support. Basta
		case (_supportCount			 			> 0): 
			{
				_class = "Support";				
				_portfolio = _portfolio					+ _DoHide;
				_portfolio = _portfolio					+ _DoSupport;
				
			};
			
		//Support . This version has no clue what to do with this shit. We just go do nothing i gues. Forget about this boys.
		case (_autonomousCount			 		==  _totalCount): 
			{
				_class = "Autonomous";
				_speed = "SLOW";
				_portfolio = _portfolio					+ _DoWait;
				
				
				//No guns but do hold space? We are a transporter

				if (!_VehicleHasGuns and _EnoughCargo ) then
				{
				
				_portfolio = _portfolio					+_DoPatrol;				
				};
				
				//Please, for the love of god check if we have guns before we charge in.
				if (_VehicleHasGuns) then
				{
				_portfolio = _portfolio					+ _DoAttack;
				
				
				};
				
			};			
			
		//Static gun.
		case (_staticCount					 		>0  ): 
			{
				_class 													= "Static";
				_speed 													= "STATIC";
				_portfolio = _portfolio					+ _DoGuard;
			};				
					
		//Submarine
		case (_submarineCount				 		==  _totalCount): 
			{
				//Later version might make them to transports. Now this is it.
				_class 													= "Submarine";				
				_speed													= "MEDIUM";				
				_portfolio = _portfolio					+ _DoPatrol;
			};							
			
	//This is the 'what the hell did you give me support'. If we have no clue what it is. Then just let it do what it is good at.
	 default
    {
        _class 													= "Unknown";				
        if (_EnoughCargo) then {_speed 	= "MEDIUM";}; 
        _portfolio = _portfolio					+ _DoPatrol;
        //If we have infantry, recon's or vehicles with guns, its ok.
				if (_VehicleHasGuns or (_reconCount>0) or (_infantryCount>0)) then
				{
					_portfolio = _portfolio					+ _DoAttack;
					_portfolio = _portfolio					+ _DoClear;
				};
    };
};



[_Class,_speed,_points,_portfolio,_CargoCount]