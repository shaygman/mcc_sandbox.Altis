#define MCC_SANDBOX2_IDD 2000
#define MCC_TRAPS_TYPE 2007
#define MCC_TRAPS_OBJECT 2008
#define MCC_TRAPS_EXPLOSIN_SIZE 2009
#define MCC_TRAPS_EXPLOSIN_TYPE 2010
#define MCC_TRAPS_TARGET_FACTION 2011
#define MCC_TRAPS_JAMMABLE 2012
#define MCC_TRAPS_DISARM 2013
#define MCC_TRAPS_TRIGGER 2014
#define MCC_TRAPS_PROXIMITY 2015
#define MCC_TRAPS_AMBUSH 2016

//Made by Shay_Gman (c) 09.10

disableSerialization;
private ["_spawnType","_IEDtype","_trapsArray","_mccdialog"];
_mccdialog = (uiNamespace getVariable "MCC_groupGen_Dialog");


if (mcc_missionmaker == (name player)) then 	{
	_spawnType = _this select 0; 	//Zone or single
	_IEDtype = lbCurSel MCC_TRAPS_TYPE;	//Type of IED to spawn
	switch (lbCurSel MCC_TRAPS_EXPLOSIN_SIZE) do {case 0:{MCC_trapvolume = ["small"];};	case 1:{MCC_trapvolume = ["medium"];}; case 2:{MCC_trapvolume = ["large"];}; case 3:{MCC_trapvolume = ["at"];};};	//Size of the explosion
	IEDExplosionType = lbCurSel MCC_TRAPS_EXPLOSIN_TYPE;	//Type of the explosion
	IEDDisarmTime = lbCurSel MCC_TRAPS_DISARM;	//Time to disarm the IED
	IEDJammable = cbChecked (_mccdialog displayCtrl MCC_TRAPS_JAMMABLE);	//Can jam the IED with CREW device
	IEDTriggerType = lbCurSel MCC_TRAPS_TRIGGER;	//The type of trigger for the IED
	trapdistance = MCC_ied_proxArray select (lbCurSel MCC_TRAPS_PROXIMITY);	//The minimum distance to activate the IED
	iedside = MCC_ied_targetArray select (lbCurSel MCC_TRAPS_TARGET_FACTION);	//The target faction
	MCC_IEDCount = MCC_IEDCount +1;

	switch (_IEDtype) do		//Which trap do we want
	{
		case 0:
		{
			_trapsArray = MCC_ied_small;
		};

		case 1:
		{
			_trapsArray = MCC_ied_medium;
		};

		case 2:
		{
			_trapsArray = MCC_ied_wrecks;
		};

		case 3:
		{
			_trapsArray = MCC_ied_hidden;
		};

		case 4:
		{
			_trapsArray = MCC_ied_mine;
		};

		case 5:
		{
			_trapsArray = U_AMMO;
		};

		case 6:
		{
			_trapsArray = U_GEN_CAR;
		};

		case 7:
		{
			_trapsArray = U_GEN_SOLDIER;
		};

		case 8:
		{
			_trapsArray = U_GEN_SOLDIER;
		};
	};

	if (_spawnType==0) then
		{
			if ((_IEDtype <= 3) || (_IEDtype == 5) || (_IEDtype == 6)) then	//if object
			{
				IedName = [format ["ied_%1", MCC_IEDCount]];
				if ((lbCurSel MCC_TRAPS_OBJECT) == -1) exitWith {};
				trapkind = [(_trapsArray select (lbCurSel MCC_TRAPS_OBJECT)) select 1];
				hint "click on the map to place the trap";
				if (MCC_capture_state) then {
					onMapSingleClick format ["_nul=[""%1"",_pos] call MCC_3D_PLACER;closeDialog 0;onMapSingleClick """";",(trapkind select 0)];
					MCC3DRuning = true;
					while {MCC3DRuning} do {
						MCC3DgotValue = false;
						while {!MCC3DgotValue && MCC3DRuning} do {sleep 0.2};
						if (MCC3DRuning) then {
							MCC_capture_var=MCC_capture_var + FORMAT ["
							[[%1 , %2 select 0, %3 select 0, %4, %5 , %6, %7, %8, %9, %10 select 0,%11,false],""MCC_fnc_trapSingle"",false,false] call BIS_fnc_MP;
							"
							, MCC3DValue select 0
							, trapkind
							, MCC_trapvolume
							, IEDExplosionType
							, IEDDisarmTime
							, IEDJammable
							, IEDTriggerType
							, trapdistance
							, iedside
							, IedName
							, MCC3DValue select 1
							];
							MCC3DgotValue = false;
						};

						Object3D = (trapkind select 0) createVehicle [0,0,0];
						Object3D enableSimulation false;
						Object3D AddEventHandler ["HandleDamage", {False}];

						sleep 0.1;
					};
				} else {
					onMapSingleClick format ["_nul=[""%1"",_pos] call MCC_3D_PLACER;closeDialog 0;onMapSingleClick """";",(trapkind select 0)];
					MCC3DRuning = true;

					while {MCC3DRuning} do {
						MCC3DgotValue = false;
						while {!MCC3DgotValue && MCC3DRuning} do {sleep 0.2};

						if (MCC3DRuning) then {
							[[MCC3DValue select 0 , trapkind select 0, MCC_trapvolume select 0, IEDExplosionType, IEDDisarmTime , IEDJammable, IEDTriggerType, trapdistance, iedside, IedName select 0, MCC3DValue select 1,false,east],"MCC_fnc_trapSingle",false,false] call BIS_fnc_MP;
							sleep 0.1;
							MCC3DgotValue = false;
						};

						Object3D = (trapkind select 0) createVehicle [0,0,0];
						Object3D enableSimulation false;
						Object3D AddEventHandler ["HandleDamage", {False}];

						sleep 0.1;
					};
				};
			};

			if (_IEDtype == 4) then	//if Mine
			{
				trapkind = [(_trapsArray select (lbCurSel MCC_TRAPS_OBJECT)) select 1];
				IedName = [format ["mine_field_%1", MCC_IEDCount]];
				MCC_drawMinefield = true;
				Mshape = "RECTANGLE";
				Mcolor = "ColorRed";
				Mtype = "GRID";
				hint "Left click on and drag a box on the map to create a minefield";
				waituntil {!MCC_drawMinefield};
				if (MCC_capture_state) then {
					MCC_capture_var=MCC_capture_var + FORMAT ['
					[[%1 select 0, %2 select 0,%3,%4],"MCC_fnc_mineSingle",false,false] call BIS_fnc_MP;
					'
					, trapkind
					, IedName
					, MCC_drawBoxZonePos
					, MCC_drawBoxZoneSize
					];
				} else {
					[[trapkind select 0,IedName select 0,MCC_drawBoxZonePos ,MCC_drawBoxZoneSize],"MCC_fnc_mineSingle",false,false] call BIS_fnc_MP;
				};
			};

			if (_IEDtype == 7) then	//if Armed Civilian
			{
				IedName = [format ["Armed_Civilian_%1", MCC_IEDCount]];
				trapkind = [(_trapsArray select (lbCurSel MCC_TRAPS_OBJECT)) select 1];
				hint "click on the map to place the trap";
				if (MCC_capture_state) then	{
					onMapSingleClick format ["_nul=[""%1"",_pos] call MCC_3D_PLACER;closeDialog 0;onMapSingleClick """";",(trapkind select 0)];
					MCC3DRuning = true;
					while {MCC3DRuning} do	{
						MCC3DgotValue = false;
						while {!MCC3DgotValue && MCC3DRuning} do {sleep 0.2};

						if (MCC3DRuning) then {
							MCC_capture_var=MCC_capture_var + FORMAT ["
							[[%1 , %2 select 0, %3 , %4 select 0, %5],""MCC_fnc_ACSingle"",false,false] call BIS_fnc_MP;
							"
							, MCC3DValue select 0
							, trapkind
							, iedside
							, IedName
							, MCC3DValue select 1
							];

							MCC3DgotValue = false;
						};

						Object3D = (trapkind select 0) createVehicle [0,0,0];
						Object3D enableSimulation false;
						Object3D AddEventHandler ["HandleDamage", {False}];

						sleep 0.1;
					};
				} else {
					onMapSingleClick format ["_nul=[""%1"",_pos] call MCC_3D_PLACER;closeDialog 0;onMapSingleClick """";",(trapkind select 0)];
					MCC3DRuning = true;
					while {MCC3DRuning} do {
						MCC3DgotValue = false;
						while {!MCC3DgotValue && MCC3DRuning} do {sleep 0.2};
						if (MCC3DRuning) then {
							[[MCC3DValue select 0 , trapkind select 0, iedside, IedName select 0, MCC3DValue select 1],"MCC_fnc_ACSingle",false,false] call BIS_fnc_MP;
							MCC3DgotValue = false;
						};

						Object3D = (trapkind select 0) createVehicle [0,0,0];
						Object3D enableSimulation false;
						Object3D AddEventHandler ["HandleDamage", {False}];

						sleep 0.1;
					};
				};
			};

			if (_IEDtype == 8) then	//if Suicide bomber
			{
				trapkind = [(_trapsArray select (lbCurSel MCC_TRAPS_OBJECT)) select 1];
				hint "click on the map to place the trap";
				if (MCC_capture_state) then {
						onMapSingleClick " 	hint ""trap captured."";
								MCC_capture_var=MCC_capture_var + FORMAT ['
								[[%1 , %2 select 0, %3 select 0, %4, %5],""MCC_fnc_SBSingle"",true,false] call BIS_fnc_MP;
								'
								, _pos
								, trapkind
								, MCC_trapvolume
								, IEDExplosionType
								, iedside
								];
								onMapSingleClick """";";
					} else {
						onMapSingleClick " 	hint ""trap placed."";
								[[_pos , trapkind select 0,MCC_trapvolume select 0, IEDExplosionType, iedside],""MCC_fnc_SBSingle"",true,false] call BIS_fnc_MP;
								onMapSingleClick """";";
					};
			};
		};

	if (_spawnType==1) then	{ //Ambush placing
			IedName = [format ["Ambush_Group_%1", MCC_IEDCount]];
			IEDAmbushspawnname = "";
			if ((lbCurSel MCC_TRAPS_AMBUSH) == (count GEN_INFANTRY)) then {MCC_IEDisSpotter = 1};		//Spotter civilian
			if ((lbCurSel MCC_TRAPS_AMBUSH) > (count GEN_INFANTRY)) then {MCC_IEDisSpotter = 3};		//Spotter camuflaged
			if ((lbCurSel MCC_TRAPS_AMBUSH) < (count GEN_INFANTRY)) then
			{
				MCC_IEDisSpotter = 0;															//Not a spotter
				IEDAmbushspawnname = GEN_INFANTRY select (lbCurSel MCC_TRAPS_AMBUSH) select 2; 		//Group
			};
		hint "click, hold and then drag the cursor to place the ambushe group pointing the desired direction";
		MCC_ambushPlacing = true;
		};
	};
