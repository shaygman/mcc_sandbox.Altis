//==================================================================MCC_fnc_CBU===============================================================================================
// drop a bomb that explode to some skeets with paracute the explode to some kind of CBU
// Example: [_bomb, CBU_type] spawn MCC_fnc_CBU;
// _bomb = position,  bomb position
// CBU_type = string, MCC_CBU_MINES, MCC_CBU_WP, MCC_CBU_CS
//==================================================================================================================================================================================			
	MCC_CBU_EXPLOSION =
		{
			private ["_skeet","_para", "_split","_pos","_x"];
			_skeet = _this select 0;
			_para = _this select 1;
			WaitUntil{(getpos _skeet select 2) < 100};
			_pos = getpos _skeet;
			_split = "HelicopterExploSmall" createvehicle _pos;
			deletevehicle _skeet;
			deletevehicle _para;
			for [{_x = 1},{_x <= 20},{_x = _x+1}] do 
				{
					sleep 0.1;
					_skeet = "g_30mm_he" createvehicle _pos; 
					_skeet setVelocity [30-(random 60),30-(random 60),-(random 30)]; 
				};
		};
	
	MCC_CBU_MINES =
		{
			private ["_skeet","_para", "_split","_pos","_x","_mine"];
			_skeet = _this select 0;
			_para = _this select 1;
			WaitUntil{(getpos _skeet select 2) < 100};
			_pos = getpos _skeet;
			_split = "HelicopterExploSmall" createvehicle _pos;
			deletevehicle _skeet;
			deletevehicle _para;
			for [{_x = 1},{_x <= 20},{_x = _x+1}] do 
				{
					sleep 0.1;
					_mine = "Mine" createvehicle [(_pos select 0)+100-(random 200),(_pos select 1)+100-(random 200),0]; 
				};
		};
	
	MCC_CBU_WP =
		{
			private ["_skeet","_para", "_split","_pos","_x","_mine"];
			_skeet = _this select 0;
			_para = _this select 1;
			WaitUntil{(getpos _skeet select 2) < 100};
			_pos = getpos _skeet;
			_split = "HelicopterExploSmall" createvehicle _pos;
			deletevehicle _skeet;
			deletevehicle _para;
			for [{_x = 1},{_x <= 10},{_x = _x+1}] do 
				{
					sleep 0.1;
					_skeet = "ACE_M34" createvehicle _pos; 
					_skeet setVelocity [30-(random 60),30-(random 60),-(random 30)]; 
				};
		};
	
	MCC_CBU_CS =
		{
			private ["_skeet","_para", "_split","_pos","_x","_mine"];
			_skeet = _this select 0;
			_para = _this select 1;
			WaitUntil{(getpos _skeet select 2) < 100};
			_pos = getpos _skeet;
			_split = "HelicopterExploSmall" createvehicle _pos;
			deletevehicle _skeet;
			deletevehicle _para;
			for [{_x = 1},{_x <= 10},{_x = _x+1}] do 
				{
					sleep 0.1;
					_skeet = "ACE_M7A3" createvehicle _pos; 
					_skeet setVelocity [30-(random 60),30-(random 60),-(random 30)]; 
				};
		};

private ["_bomb","_split", "_vel", "_x","_y","_type"];
_bomb = _this select 0;
_type = _this select 1;
_vel = velocity _bomb;
for [{_x = 1},{_x <= 4},{_x = _x+1}] do 
	{
		sleep 0.5;
		_para = "ParachuteC" createVehicle [getpos _bomb select 0,getpos _bomb select 1,3000];		//Make the bomb and the parachute
		_para setpos [getpos _bomb select 0,getpos _bomb select 1,(getpos _bomb select 2) -10];
		_skeet = "Barrel4" createvehicle [getpos _bomb select 0,getpos _bomb select 1,3000]; 
			for [{_y = 1},{_y <= 3},{_y = _y+1}] do 
					{
						_skeet attachTo [_para, [0,0,0]];
						_para setVelocity [(_vel select 0)/2, (_vel select 1)/2,(_vel select 2)/2];
						sleep 0.02;
					};
		[_skeet, _para] spawn call (compile _type);
	};
_split = "HelicopterExploBig" createvehicle getpos _bomb; 
deletevehicle _bomb;

	
