//==================================================================MCC_fnc_cover===============================================================================================
//Manage cover mechanics
// Example: [] call MCC_fnc_cover;
//===========================================================================================================================================================================
private ["_center","_left","_right","_up","_cover","_centerFront","_leftFront","_rightFront","_upFront","_cover","_headPos","_currentAnim","_string",
			 "_centerFrontFar","_stance","_isWall","_pos","_leftFrontClose","_rightFrontClose","_rightClose","_leftClose"];

if(alive player && vehicle player == player) then
{
	//get relative positions
	_headPos 		= player selectionPosition "head";
	_left 			= player modelToWorld [(_headPos select 0)-0.6,(_headPos select 1),(_headPos select 2)];
	_leftClose		= player modelToWorld [(_headPos select 0)-0.2,(_headPos select 1),(_headPos select 2)];
	_right 			= player modelToWorld [(_headPos select 0)+0.6,(_headPos select 1),(_headPos select 2)];
	_rightClose		= player modelToWorld [(_headPos select 0)+0.2,(_headPos select 1),(_headPos select 2)];
	_up 			= player modelToWorld [(_headPos select 0),(_headPos select 1),(_headPos select 2)+0.3];
	_center 		= player modelToWorld [(_headPos select 0),(_headPos select 1),(_headPos select 2)];
	_leftFront 		= player modelToWorld [(_headPos select 0)-0.6,(_headPos select 1)+2,(_headPos select 2)];
	_leftFrontClose	= player modelToWorld [(_headPos select 0)-0.2,(_headPos select 1)+2,(_headPos select 2)];
	_rightFront 	= player modelToWorld [(_headPos select 0)+0.6,(_headPos select 1)+2,(_headPos select 2)];
	_rightFrontClose= player modelToWorld [(_headPos select 0)+0.2,(_headPos select 1)+2,(_headPos select 2)];
	_upFront 		= player modelToWorld [(_headPos select 0),(_headPos select 1)+2,(_headPos select 2)+0.3];
	_centerFront	= player modelToWorld [(_headPos select 0),(_headPos select 1)+1,(_headPos select 2)];
	_centerFrontFar	= player modelToWorld [(_headPos select 0),(_headPos select 1)+3,(_headPos select 2)];
	_stance 		= stance player;

	if ((missionNameSpace getVariable ["MCC_changeRecoil",true]) && _stance == "PRONE" && unitRecoilCoefficient player > 0.5) then
	{
		player setVariable ["MCC_recoilCoef", 0.3];
		player setUnitRecoilCoefficient (0.3 * unitRecoilCoefficient player);

		/*	//Not needed anymore since the new Marksman DLC
		[] spawn
		{
			if (missionNameSpace getVariable ["MCC_coverUI",true] && (player getVariable ["MCC_mirrorCamOff",true])) then
			{
				while {stance player == "PRONE"} do
				{
					if !(player getVariable ["MCC_behindCover", false]) then
					{
						[format ["<img align='left' size='1.5' image='%1data\cover\bipods.paa'/>",MCC_path],0.5,1,0.1,0,0,1] spawn BIS_fnc_dynamicText;
					};
					sleep 0.1;
				};
			};

			waituntil {stance player != "PRONE"};
			player setUnitRecoilCoefficient 1;
		};
		*/
	};



	//Are we behind cover
	if (lineIntersects [ATLtoASL _center, ATLtoASL _centerFront] ) then {
		player setVariable ["MCC_behindCover", true];
		_cover = switch (true) do
				{
					case (!(lineIntersects [ATLtoASL _up, ATLtoASL _upFront])): {"up"};
					case (!(lineIntersects [ATLtoASL _right, ATLtoASL _rightFront]) && (lineIntersects [ATLtoASL _rightClose, ATLtoASL _rightFrontClose])): {"right"};
					case (!(lineIntersects [ATLtoASL _left, ATLtoASL _leftFront]) && (lineIntersects [ATLtoASL _leftClose, ATLtoASL _leftFrontClose])): {"left"};
					case (!(lineIntersects [ATLtoASL _center, ATLtoASL _centerFront])): {"center"};
					default {"none"}
				};

		//are we behind a wall
		_isWall = if (cursorTarget isKindOf "LandVehicle" || cursorTarget isKindOf "Air") then
		{
			false
		}
		else
		{
		  if (_stance in ["STAND","CROUCH"] && _cover in ["up","center"] && !(lineIntersects [ATLtoASL _centerFront, ATLtoASL _centerFrontFar])) then {true} else {false};
		};


		//Wall climbing
		if (_isWall && _cover == "up") then
		{
			_wallHigh = "";
			_start = player modelToWorld [0,0,2.5];
			_startL = player modelToWorld [0.4,0,2.5];
			_startR = player modelToWorld [-0.4,0,2.5];
			_target = player modelToWorld [0,2,2.5];
			if (!(lineIntersects [ATLtoASL _start, ATLtoASL _target]) &&
				!(lineIntersects [ATLtoASL _startL, ATLtoASL _target]) &&
				!(lineIntersects [ATLtoASL _startR, ATLtoASL _target])
				) then {_wallHigh = "high"};

			_start = player modelToWorld [0,0,1.5];
			_startL = player modelToWorld [0.4,0,1.5];
			_startR = player modelToWorld [-0.4,0,1.5];
			_target = player modelToWorld [0,3,1.5];
			if (!(lineIntersects [ATLtoASL _start, ATLtoASL _target]) &&
				!(lineIntersects [ATLtoASL _startL, ATLtoASL _target]) &&
				!(lineIntersects [ATLtoASL _startR, ATLtoASL _target])
				) then {_wallHigh = "low"};
			player setVariable ["MCC_wallAhead", _wallHigh];
		};

		//UI?
		if ((missionNameSpace getVariable ["MCC_coverUI",true]) && (player getVariable ["MCC_mirrorCamOff",true])) then
		{
			_string = "";
			switch (_cover) do
			{
				case "up": {_string = format ["<img align='left' size='1' image='%1data\cover\coverU.paa'/>",MCC_path]};
				case "right": {_string = format ["<img align='left' size='1' image='%1data\cover\coverR.paa'/>",MCC_path]};
				case "left": {_string = format ["<img align='left' size='1' image='%1data\cover\coverL.paa'/>",MCC_path]};
			};

			if ((player getVariable ["MCC_wallAhead", ""])!="") then {
				if (MCC_isCBA) then {
						_string = _string + format ["<br/><t font='puristaMedium' size='0.4' align='left'> Press %1 to vault",["MCC","vaultOver"] call MCC_fnc_getKeyFromCBA];
					} else {
						_string = _string + format ["<br/><t font='puristaMedium' size='0.4' align='left'> Press %1 to vault",keyName ((actionKeys "GetOver") select 0)];
					};
			};

			if (alive player) then {[_string,0.5,1,0.1,0,0,1] spawn BIS_fnc_dynamicText};
		};


		if (cameraView == "GUNNER" && _cover in ["up","left","right"] && speed player == 0) then
		{
			_currentAnim = animationState player;
			_pos = getpos player;

			switch(_cover) do {
				case "up":
				{
					player playactionNow "AdjustF";
				};
				case "right":
				{
					player playactionNow "AdjustR";
				};
				case "left":
				{
					player playactionNow "AdjustL";
				};
			};

			//Release the stucking anim
			sleep 0.05;
			player playMoveNow animationState player;
			sleep 0.1;

			//Work around for prone
			if (cameraView == "GUNNER") then
			{
				/* ABSOULTE Marksman DLC
				if ((missionNameSpace getVariable ["MCC_changeRecoil",true]) && stance player != "PRONE") then
				{
					player setVariable ["MCC_recoilCoef", 0.4];
					player setUnitRecoilCoefficient (0.4 * unitRecoilCoefficient player);
				};
				*/
				while {cameraView == "GUNNER" && (_pos distance getpos player)<1.5} do
				{
					/* ABSOULTE Marksman DLC
					if ((missionNameSpace getVariable ["MCC_coverUI",true]) && (missionNameSpace getVariable ["MCC_changeRecoil",true])) then
					{
						[format ["<img align='left' size='1.5' image='%1data\cover\bipods.paa'/>",MCC_path],0.5,1,0.1,0,0,1] spawn BIS_fnc_dynamicText;
					};
					*/

					sleep 0.1;
				};
				//player playactionNow format ["player%1",_stance];
				player playmoveNow _currentAnim;
				if (_currentAnim in ["aadjpknlmstpsraswrflddown","aadjpercmstpsraswrflddown","aadjpknlmstpsraswrfldup","aadjppnemstpsraswrfldup"]) then
				{
					sleep 0.4;
					player switchMove _currentAnim;
				};

				/* ABSOULTE Marksman DLC
				if (missionNameSpace getVariable ["MCC_changeRecoil",true]) then
				{
					player setUnitRecoilCoefficient ((player getVariable ["MCC_recoilCoef", 0.4])/ unitRecoilCoefficient player);
				};
				*/
			};
		};
	} else {
		player setVariable ["MCC_behindCover", false];
	};
};