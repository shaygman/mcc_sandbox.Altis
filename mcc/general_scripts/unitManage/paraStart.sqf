private ["_unit","_plane","_positions","_dir","_isHalo","_jumpReady","_unitPosition","_dropPos","_fakePlane",
		 "_haveGPS","_haveMAP","_isCargo","_y","_pos","_vehicle","_init"];
_plane 		= _this select 0;												//where from
_unit 		= _this select 1;												//Who is jumping
_unitNumber	= _this select 2;												//what is his jumper number
_dropPos	= _this select 3;												//where is the LZ
_haveGPS	= false; 
_haveMAP	= false; 
_isCargo	= false; 

_positions 	= [[0.75,-2,-4.55],[-0.75,-2,-4.55],[0.75,-0.5,-4.55],[-0.75,-0.5,-4.55],[0.75,1,-4.55],[-0.75,1,-4.55],
			   [0.75,2.5,-4.55],[-0.75,2.5,-4.55],[0.75,4,-4.55],[-0.75,4,-4.55],[0.75,5.5,-4.55],[-0.75,5.5,-4.55]];
			   
_dir			= 180;														//set the units looking the ramp
_unitPosition 	= _positions select _unitNumber;
_isHalo			= _plane getvariable "MCCisHALO"; 
_jumpReady		= _plane getvariable "MCCjumpReady"; 

sleep .1;

if (isNull _unit) exitwith {};

if (!local _unit) exitwith {};

titleText ["","BLACK FADED",5];	
while {!_isCargo && (alive _plane)} do {
		_unit assignAsCargo _plane;
		_unit MoveInCargo [_plane,_unitNumber];
		sleep 0.5;
		if (vehicle _unit == _plane) then {_isCargo = true};
	};
sleep 5;
titleText ["","BLACK IN",5];	

if (alive _unit && alive _plane) then {
	while {!_jumpReady} do {sleep 1;_jumpReady = _plane getvariable "MCCjumpReady"}; 	//let them sit for a while
	titleText ["Get Ready To Jump","BLACK FADED",5];												//Make them stand on the ramp		
	_unit allowdamage false; 		
	_unit action ["getout",vehicle _unit];
	unassignVehicle _unit;
	
	//_unit hideObject true;
	_unit setPos [(getPos _unit)select 0,(getPos _unit)select 1,(((getPos _unit)select 2)+1000)];
	
	
	_unit switchMove "";
	sleep 2; 
	_unit attachto [_plane,_unitPosition];
	_unit setDir _dir;
	_unit setDir _dir;
	
	if (!isPlayer _unit) then	{
		_unit disableAI "MOVE"; 
	};

	if ((primaryWeapon _unit) != "") then	{
		if ((currentWeapon _unit) == (primaryWeapon _unit)) then	{
			_unit  playMove "AidlPercMstpSlowWrflDnon_player_0S";
		};
	};

	if (!isPlayer _unit) then	{
		_unit disableAI "MOVE"; 
	};

	sleep 2;
	titleText ["","BLACK IN",5];
	
	waituntil {_plane getVariable "MCCJumperNumber" == _unitNumber}; //wait for your turn
	
	if (!isPlayer _unit) then {										//Start the run
				_init = format ["_this playMove ""AmovPercMevaSrasWrflDf"";_this setdir %1",_dir];
				[[[netid _unit,_unit], _init], "MCC_fnc_setVehicleInit", true, true] spawn BIS_fnc_MP;
				}	else	{
						_unit  playMove "amovpercmevasraswrfldf";						
					};
	_y = _unitPosition select 1;
			
	while {(_y > -7)} do {												
	if ((animationState _unit) != "AmovPercMevaSrasWrflDf") then	{
		if (!isPlayer _unit) then {
				_init = format ["_this switchMove ""AmovPercMevaSrasWrflDf"";_this setdir %1",_dir];
				[[[netid _unit,_unit], _init], "MCC_fnc_setVehicleInit", true, true] spawn BIS_fnc_MP;
				}	else	{
						_unit  switchMove "amovpercmevasraswrfldf";						
					};
		};
					
		if ((animationState _unit) == "AmovPercMevaSrasWrflDf") then	{
				_y = _y - 0.15;
			};
			
		_unit attachto [_plane,[_unitPosition select 0, _y, _unitPosition select 2]];
		_unit setDir _dir;
						
		sleep 0.001;
		};
		
	_plane setVariable ["MCCJumperNumber",_unitNumber + 1,true];
	_pos = getpos _unit;
	detach _unit;
	_init = "_this switchmove ""HaloFreeFall_non"";";
	[[[netid _unit,_unit], _init], "MCC_fnc_setVehicleInit", true, true] spawn BIS_fnc_MP;
	sleep 2; 
		
	//Open Chute
	if (!isPlayer _unit) then	{
			_unit enableAI "MOVE"; 
		};
	
	if (_isHalo) then 
	{
		[_unit,getpos _unit select 2] exec "ca\air2\halo\data\Scripts\HALO_init.sqs";
	}
	else
	{
		if (isPlayer _unit)	then
		{
			if ((side _unit)== WEST) then 
			{
				_vehicle = "ParachuteWest" CreateVehicle getPos _unit;
			}
			else
			{
				_vehicle = "ParachuteEast" CreateVehicle getPos _unit;
			};

			waituntil {!isNil "_vehicle"};
			_pos = [position _unit select 0, position _unit select 1, (position _unit select 2)];
			_vehicle setPos _pos;
			_unit MoveInDriver _vehicle;
			sleep 0.001;
			playsound "BIS_Steerable_Parachute_Opening";
			setAperture 0.05; 
			setAperture -1;
					
			"DynamicBlur" ppEffectEnable true;
			"DynamicBlur" ppEffectAdjust [8.0];
			"DynamicBlur" ppEffectCommit 0.01;
			sleep 1; 
			"DynamicBlur" ppEffectAdjust [0.0];
			"DynamicBlur" ppEffectCommit 3;
			sleep 3;
			"DynamicBlur" ppEffectEnable false;
			"RadialBlur" ppEffectAdjust [0.0, 0.0, 0.0, 0.0];
			"RadialBlur" ppEffectCommit 1.0;
			"RadialBlur" ppEffectEnable false;					
		}
		else
		{
			[_unit,getpos _unit select 2] exec "ca\air2\halo\data\Scripts\HALO_init.sqs";
		};				
	};			
	
	_unit allowdamage true; 
	while {((getpos _unit) select 2) > 1} do {sleep 1};   //Wait till the unit touch the ground
	_init = "_this switchmove """";";
	[[[netid _unit,_unit], _init], "MCC_fnc_setVehicleInit", true, true] spawn BIS_fnc_MP;
};
