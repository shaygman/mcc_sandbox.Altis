/*	
	autor: !R	
	
	5.1.0
*/
	

	
// get new position [x,y,x] from pos in distance and angle.
// [_pos, _distance, _angle] call R_relPos3D;
// [newX,newY,Z]	
R_relPos3D = 
	{
		private["_p","_d","_a","_x","_y","_z","_xout","_yout"];
		_p=_this select 0; 
		_x=_p select 0; 
		_y=_p select 1; 
		_z=_p select 2;
		_d=_this select 1; 
		_a=_this select 2; 
		_xout=_x + sin(_a) * _d; 
		_yout=_y + cos(_a) * _d;
		[_xout,_yout,_z]
	};

	
// [_unit] spawn R_ThrowSmoke;
R_ThrowSmoke = 
	{
		private ["_unit","_shell",
					"_moves","_unitPos","_pos","_flare","_direction"];

		/*
		_stanThrow = ["AwopPercMstpSgthWrflDnon_Start1", "AwopPercMstpSgthWrflDnon_Throw1","AwopPercMstpSgthWrflDnon_End1"];	
		_kneeThrow = ["AwopPknlMstpSgthWrflDnon_Start", "AwopPknlMstpSgthWrflDnon_Throw" ,"AwopPknlMstpSgthWrflDnon_End"];
		_proneThrow= ["AwopPpneMstpSgthWrflDnon_Start", "AwopPpneMstpSgthWrflDnon_Throw" ,"AwopPpneMstpSgthWrflDnon_End"]; 
		*/
		
		_moves = ["AwopPercMstpSgthWrflDnon_Start1","AwopPknlMstpSgthWrflDnon_Start","AwopPpneMstpSgthWrflDnon_Start"];

		_unit = _this select 0;
		_shell = "SmokeShell";
		_unitPos = unitPos _unit; 
		
		//Animation
		switch (_unitPos) do {   
			
			case "Auto":
			{	
				_unit playMove (_moves select 1);	
			};
		
			case "Up":
			{	
				_unit playMove (_moves select 0);	
			};
		
			case "Middle":
			{	
				_unit playMove (_moves select 1);	
			};
			
			case "Down":
			{	
				_unit playMove (_moves select 2);	
			};
		};	
		
		sleep 4;
		_direction = direction _unit;		
		
		// use such bypass as setvelocity does not work in MP
		_pos = position _unit;
		_pos = [(_pos select 0),(_pos select 1),(_pos select 2)+1.5];
		_pos = [_pos, 18, _direction] call R_relPos3D;
				
		if (alive _unit && canmove _unit) then {	
			_flare = _shell createVehicle _pos;
		};
		
		// setvelocity does not work in MP http://dev-heaven.net/issues/17949
		/*
		_vector = [18,direction _unit,0] call C B A_fnc_polar2vect;

		_pos=position _unit;
		_pos=[(_pos select 0),(_pos select 1),(_pos select 2)+2];
		_flare = _shell createVehicle _pos;
		_flare setPos _pos;
		_flare setvelocity _vector;	
		
		*/
	};
	
	
	
	// [_unit] call R_FN_deleteObsoleteWaypoints;
	// leave only the last way point
	R_FN_deleteObsoleteWaypoints = 
	{
		private ["_unit","_grp"];
		
		_unit = _this select 0;
		_grp = group _unit;
		while {(count (waypoints _grp)) > 1} do
		{
			deleteWaypoint ((waypoints _grp) select 0);			
		};
	};	
	
	

	// array = [_npc] call R_FN_vehiclesUsedByGroup;
	// return array of vehicles used by group
	R_FN_vehiclesUsedByGroup =
	{
		private ["_npc","_vehicles"];
		
		_npc = _this select 0;
		_vehicles = [];
		
		if (!alive _npc) exitwith {};
		
		{
			if (( vehicle _x != _x || !(_x iskindof "Man")) && !((vehicle _x) in _vehicles)) then {
					 _vehicles = _vehicles + [vehicle _x];
			};
		} foreach units _npc;			
		
		_vehicles
	};	
	

	// array = [_vehicle]  call R_FN_unitsInCargo;
	// array of units in cargo of the vehicle (in vehicle and assigned as cargo)
	R_FN_unitsInCargo =
	{
		private ["_vehicle","_x","_unitsInCargo"]; 
		
		_vehicle = _this select 0;
		_unitsInCargo = [];
		{
			if( (assignedVehicleRole _x) select 0 == "Cargo") then
			{
				_unitsInCargo = _unitsInCargo + [_x];			
			};			
		} forEach crew _vehicle;	
	
		_unitsInCargo
	};
	




	// array = [_npc] call R_FN_allUnitsInCargo;
	// array of all units in cargo of the group (not driver, commander or gunner)
	R_FN_allUnitsInCargo =
	{
		private ["_npc","_vehicles","_unitsInCargo","_allUnitsInCargo"];
		
		_npc = _this select 0;
		if (!alive _npc) exitwith {};
		
		_allUnitsInCargo =[];
		
		_vehicles = [_npc] call R_FN_vehiclesUsedByGroup;
		
		{
			_unitsInCargo = [_x]  call R_FN_unitsInCargo;
			_allUnitsInCargo = _allUnitsInCargo + _unitsInCargo; 		
		
		} foreach _vehicles;
		
		_allUnitsInCargo
	};
	
	
	// old MON_GetOutDist
	// <- _npc
	// <- _targetPos:  position for exiting(if no waypoint used)
	// <- _atdist: minimal dist to the _targetpos do getout 
	// -> nothing
	// nul = [_npc,_targetpos,_atdist] spawn R_SN_GetOutDist;
	R_SN_GetOutDist = {
		private["_vehicle","_npc","_target","_atdist","_getout","_dogetout","_driver","_commander","_targetpos","_dist","_vehpos","_vehicles"];	
	
		_npc = _this select 0;
		_targetpos = _this select 1;
		_atdist = _this select 2; // minimal dist to the target	to do getOut

		_dogetout = []; // units to do getout
		_vehicles = []; // vehs used by the group
	
		if (!alive _npc) exitwith{};	
		
		_vehicle = vehicle _npc;
		_vehpos = getpos _vehicle;
		
		_dist = round([_vehpos,_targetpos] call KRON_distancePosSqr); // dist to the target

		// if (KRON_UPS_Debug>0) then {player sidechat format["%1: Getoutdist dist=%2 atdist=%3 ",typeof _vehicle,_dist, _atdist]}; 		

		// if _npc is in vehicle
		if ( _vehicle != _npc || !(_npc iskindof "Man")) then {
			
			if ( (_dist) <= _atdist ) then {			
				_vehicles = [_npc] call R_FN_vehiclesUsedByGroup; // vehicles use by the group			
				{
					_dogetout = [_x] call R_FN_unitsInCargo; // units cargo in the vehicle
					_driver = driver _x;
					
					if ( count _dogetout > 0 ) then { 	
						//Stop the veh for 5.5 sek		
						nul = [_vehicle,5] spawn MON_doStop;					
						
						sleep 0.8; // give time to actualy stop
						
						{					
							_x spawn MON_GetOut;	
							sleep 0.3;												
						} foreach _dogetout;				

						//We removed the id to the vehicle so it can be reused
						_x setVariable ["UPSMON_grpid", 0, false];	
						_x setVariable ["UPSMON_cargo", [], false];	
						
						[_npc,_x, _driver] spawn MON_checkleaveVehicle; // if every one outside, make sure driver can walk
						sleep 0.01;		
					};
				} foreach _vehicles;
			};
		};
	};
	
	// #define GOTHIT(X) 	([X] call R_FN_GOTHIT)
	// nul = [_grpId] call R_FN_GOTHIT; 
	R_FN_GOTHIT =
	{
		_grpId = _this select 0;
		if ((R_GOTHIT_ARRAY select _grpId) != 0) then
		{
			true
		}
		else
		{
			false
		}	
	};
	
		// use in gothit proces
	// nul = [_unit, _shooter] spawn R_SN_EHHIT; 
	R_SN_EHHIT = 
	{
		private ["_unit","_shooter","_grpId"];
		_unit = _this select 0;
		_shooter = _this select 1;
		_grpId = _unit getVariable ("UPSMON_grpid");
		 
		if ((side _unit != side _shooter) && (R_GOTHIT_ARRAY select _grpId) == 0) then
		{
			R_GOTHIT_ARRAY set [_grpId, 1]; 
			// if (KRON_UPS_Debug > 0) then {player globalchat format["UNIT: %1, SHOOTER :%2 %3",_unit,_shooter,side _shooter]};
		};	
	};

	
	// use in gothit proces
	// nul = [_unit, _shooter] spawn R_SN_EHKILLED; 
	R_SN_EHKILLED = 
	{
		private ["_unit","_shooter","_grpId"];
		
		_unit = _this select 0;
		_shooter = _this select 1;
		_grpId = _unit getVariable ("UPSMON_grpid");
		
		if ((side _unit != side _shooter) && (R_GOTHIT_ARRAY select _grpId) == 0) then
		{
			R_GOTHIT_ARRAY set [_grpId, 2]; 
			// if (KRON_UPS_Debug > 0) then {player globalchat format["UNIT: %1, SHOOTER :%2 %3",_unit,_shooter,side _shooter]};
		};
	};

	
	// logic is needed to display rGlobalChat
	private ["_center","_group"];
	_center = createCenter sideLogic; _group = createGroup _center;
	R_Logic_civkill = _group createUnit ["LOGIC", [2,2,1], [], 0, "NONE"];
	_group = nil;
	_center = nil;
	
	
	// used in gothit proces
	// nul = [_unit, _shooter] spawn R_SN_EHKILLEDCIV; 
	R_SN_EHKILLEDCIV = 
	{
		private ["_killer","_side"];
		_killer = _this select 1;
		
		//only if player killed a civilian
		if (isPlayer _killer) then {			
			
			KILLED_CIV_COUNTER set [0,(KILLED_CIV_COUNTER select 0) + 1];			
			
			// if (KRON_UPS_Debug > 0) then {player globalchat format["KILLER: %1, %2", side _killer,KILLED_CIV_COUNTER ]};
			switch (side _killer) do
			{
				case west:
				{
					KILLED_CIV_COUNTER set [1,(KILLED_CIV_COUNTER select 1) + 1];
				};
			
				case east:
				{
					KILLED_CIV_COUNTER set [2,(KILLED_CIV_COUNTER select 2) + 1];
				};
			
				case resistance:
				{
					KILLED_CIV_COUNTER set [3,(KILLED_CIV_COUNTER select 3) + 1];
				};
			};		
			KILLED_CIV_COUNTER set [4,_killer];
			
			//if (KRON_UPS_Debug > 0) then {player globalchat format["KILLER: %1", side _killer ]};
			if (KRON_UPS_Debug > 0) then {player globalchat format["KILLED_CIV_COUNTER: %1",KILLED_CIV_COUNTER]};
			if (R_WHO_IS_CIV_KILLER_INFO > 0) then {      
				[R_Logic_civkill, nil , rglobalChat, format ["A CIVILIAN WAS KILLED BY %1",_killer]] call RE;
			};	
		};							
	};

	
	//firedNear
	R_SN_EHFIREDNEAR = 
	{
		private ["_civ"];
		_civ = leader (_this select 0);
		_civ setspeedmode "FULL";
	};


	