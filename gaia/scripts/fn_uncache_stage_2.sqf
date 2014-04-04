if(!isServer) exitWith {};

_sf   			= _this select 0; 

_uv 				= [];
_crew 			= [];
_gv					= [];

_group = creategroup (_sf select 2);
_group  setVariable ["GAIA_zone_intend", (_sf select 3),false];


//Create Vehicles in group
{
		_veh = _x;
		_cv  = (_veh select 0)  createvehicle (_veh select 1);
		//_cv  setPosasl (_veh select 1);
		_cv setdamage (_veh select 2);
		_cv setfuel (_veh select 3);
		
		{
			_un = _group createUnit [(_x select 0), (_x select 1), [], 0, "FORM"] ;	
			_un setdamage 		(_x select 2);
			_un setskill  		(_x select 3);
			_un setrank   		(_x select 4);
			_un setdir			  (_x select 6);
			_role = (_x select 5);
			if ((_role select 0) == "Driver") then 
				{_un moveInDriver _cv ; };
			if ((_role select 0) == "Turret") then 
				{_un moveInTurret [_cv, (_role select 1)]; };
			if ((_role select 0) == "Cargo") then 
				{_un assignAsCargo  _cv; };
			
		}	foreach (_veh select 4);
		
} foreach (_sf select 0);


//Create Infantry in group
{
	//player globalchat format [" going  %1",(_x select 0)];
	//_un=(_x select 0) createUnit [(_x select 1), _group,"",(_x select 3),(_x select 4)];
	_un = _group createUnit [(_x select 0), (_x select 1), [], 0, "FORM"] ;
	
	_un setdamage 		(_x select 2);
	_un setskill  		(_x select 3);
	_un setrank   		(_x select 4);
	_un setPosasl 		(_x select 1);
	_un setdir			 	(_x select 5);

} foreach (_sf select 1);


