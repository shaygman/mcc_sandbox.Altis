//==================================================================MCC_fnc_construct_base===============================================================================================
// Example:[_pos, _anchorDir , _anchorType, _BuildTime, _side]  call  MCC_fnc_construct_base;
//==================================================================================================================================================================================
private ["_Type","_anchorType","_anchorDir","_pos","_objs","_constType","_anchor","_object","_BuildTime","_buildingObjs","_builtArray","_side","_level"];

		
_pos			= _this select 0;
_anchorDir 		= _this select 1;
_Type 			= _this select 2;
_BuildTime		= _this select 3;
_side			= _this select 4;

switch (_Type) do
{
	//hq_level_1
	case "hq1":	
	{ 
		_anchorType = "Land_TBox_F";
		_constType = "hq";
		_level = 1;
		_objs= [												
				["Land_PowerGenerator_F", [-2.6,0,-1],[[0,1,0],[0,0,1]]],
				["Land_cargo_addon01_V1_F", [3.36,0.5,-1.5],[[-1,0,0],[0,0,1]]],
				["CamoNet_INDP_open_Curator_F", [0,0,0],[[0,1,0],[0,0,1]]],
				["Land_TableDesk_F", [2.2,0.5,-1.5],[[1,0,0],[0,0,1]]],
				["Land_Camping_Light_F", [2.2,1,-1],[[1,0,0],[0,0,1]]],
				["Land_ChairWood_F", [2.8,0.5,-1.8],[[1,0,0],[0,0,1]]],
				["Land_Map_altis_F", [2.2,0.5,-1.08],[[1,0,0],[0,0,1]]]					
			  ];
	};
	
	//hq_level_2
	case "hq2":	
	{ 
		_anchorType = "Land_Slum_House03_F";
		_constType = "hq";
		_level = 2;
		_objs= [												
				["Land_PowerGenerator_F", [5,0,-0.3],[[0,1,0],[0,0,1]]],
				["Land_TTowerSmall_1_F", [5,2,6],[[0,1,0],[0,0,1]]],
				["Land_TableDesk_F", [4,2,-0.8],[[-1,0,0],[0,0,1]]],
				["Land_Camping_Light_F", [4,2.5,-0.3],[[1,0,0],[0,0,1]]],
				["Land_Metal_rack_F", [1,2.8,-0.2],[[0,1,0],[0,0,1]]],
				["Land_ChairWood_F", [3.5,2,-1.15], [[-1,0,0],[0,0,1]]],
				["Land_Laptop_unfolded_F", [4,2,-0.23],[[-1,0,0],[0,0,1]]],
				["Land_Map_altis_F", [4.3,0,1],[[0,-1,0],[-1,0,0]]],
				["Land_WaterCooler_01_old_F", [4,0.8,-0.4],[[1,0,0],[0,0,1]]],
				["Land_Sleeping_bag_brown_F", [0,2,-1.05],[[-1,0,0],[0,0,1]]],
				["Land_LuggageHeap_01_F", [-2.2,2.6,-0.65],[[1,0,0],[0,0,1]]],
				["Land_WaterCooler_01_old_F", [4,0.8,-0.4],[[1,0,0],[0,0,1]]],
				["CamoNet_BLUFOR_open_Curator_F", [0,0,1],[[0,1,0],[0,0,1]]]
			  ];
	};
	
	//hq_level_3
	case "hq3":	
	{ 
		_anchorType = "Land_Cargo_HQ_V1_F";
		_constType = "hq";
		_level = 3;
		_objs= [												
				["Land_TableDesk_F", [-1,-6,-2.8],[[0,1,0],[0,0,1]]],
				["Land_Camping_Light_F", [-0.5,-6,-2.27],[[1,0,0],[0,0,1]]],
				["Land_Rack_F", [-3,-6,-2.35],[[-1,0,0],[0,0,1]]],
				["Land_WaterCooler_01_new_F", [0.5,-6,-2.4],[[0,-1,0],[0,0,1]]],
				["Land_Laptop_unfolded_F", [-1,-6,-2.23],[[0,1,0],[0,0,1]]],
				["Land_Map_altis_F", [-1,-6.5,-1.5],[[-1,0,0],[0,1,0]]],
				["Land_PaperBox_open_full_F", [6,2,-2.8],[[0,1,0],[0,0,1]]],
				["Land_Pallet_MilBoxes_F", [3,0,-2.8],[[0,1,0],[0,0,1]]],
				["Land_CampingChair_V2_F", [-1,-5.6,-2.8],[[0,1,0],[0,0,1]]],
				["Land_Sleeping_bag_blue_folded_F", [0,3,-3.2],[[0,1,0],[0,0,1]]],
				["Land_Sleeping_bag_brown_F", [-1,2,-3.25],[[0,1,0],[0,0,1]]],
				["Land_Sleeping_bag_blue_F", [-3,2,-3.25],[[0,1,0],[0,0,1]]],
				["Land_Communication_F", [3,-6,12.5],[[1,1,0],[0,0,1]]]
			  ];
	};
	
	//storage lvl 1
	case "storage1":	
	{ 
		_anchorType = "Land_cargo_addon02_V2_F";
		_constType = "storage";
		_level = 1;
		_objs= [												
				["Land_PaperBox_open_full_F", [2,1,0],[[0,1,0],[0,0,1]]],
				["Land_Pallet_MilBoxes_F", [0,1,-0.1],[[0,1,0],[0,0,1]]],
				["Land_Pallet_MilBoxes_F", [-2,1,-0.1],[[0,1,0],[0,0,1]]],
				["Land_WaterBarrel_F", [1,-1,0],[[0,1,0],[0,0,1]]],
				["Land_Sacks_heap_F", [-1,-1,-0.2],[[0,1,0],[0,0,1]]]
			  ];
	};
	
	//storage lvl 2
	case "storage2":	
	{ 
		_anchorType = "Land_u_Addon_01_V1_F";
		_constType = "storage";
		_level = 2;
		_objs= [												
				["Land_WaterTank_F", [3.5,2,0.6],[[1,0,0],[0,0,1]]],
				["Land_WaterTank_F", [5,2,0.6],[[1,0,0],[0,0,1]]],
				["Land_PaperBox_open_full_F", [2,3,0.5],[[1,0,0],[0,0,1]]],
				["Land_PaperBox_open_full_F", [0,3,0.5],[[1,0,0],[0,0,1]]],
				["Land_Pallet_MilBoxes_F", [0,1.5,0.4],[[1,0,0],[0,0,1]]],
				["Land_Pallet_MilBoxes_F", [2,1.5,0.4],[[1,0,0],[0,0,1]]]
			  ];
	};
	
	//storage lvl 3
	case "storage3":	
	{ 
		_anchorType = "CamoNet_BLUFOR_Curator_F";
		_constType = "storage";
		_level = 3;
		_objs= [												
				["Land_PaperBox_open_full_F", [3,0,-0.7],[[0,1,0],[0,0,1]]],
				["Land_PaperBox_open_full_F", [5,0,-0.7],[[0,1,0],[0,0,1]]],
				["Land_Pallet_MilBoxes_F", [1,0,-0.9],[[0,1,0],[0,0,1]]],
				["Land_Pallet_MilBoxes_F", [1,-2,-0.9],[[0,1,0],[0,0,1]]],
				["Land_Pallet_MilBoxes_F", [4,-2,-0.9],[[0,1,0],[0,0,1]]],
				["Land_PaperBox_open_full_F", [-2,-2,-0.7],[[0,1,0],[0,0,1]]],
				["Land_Sacks_heap_F", [-1,0,-0.8],[[0,1,0],[0,0,1]]],
				["Land_Sacks_heap_F", [-4,-1,-0.8],[[1,0,0],[0,0,1]]],
				["Land_Tank_rust_F", [8.5,0,0],[[1,0,0],[0,0,1]]]
			  ];
	};
	
	//barracks lvl 1
	case "barracks1":	
	{ 
		_anchorType = "CamoNet_BLUFOR_open_Curator_F";
		_constType = "barracks";
		_level = 1;
		_objs= [												
				["Land_TablePlastic_01_F", [5,0,-0.6],[[1,0,0],[0,0,1]]],
				["Land_BakedBeans_F", [4.9,0.4,-0.1], [[1,-1,0],[0,0,1]]],
				["Land_GasCooker_F", [4.7,0,-0.06],[[1,-1,0],[0,0,1]]],
				["Land_BottlePlastic_V2_F", [5,0.3,-0.05],[[1,-1,0],[0,0,1]]],
				["Land_CerealsBox_F", [5,-0.5,0],[[1,-1,0],[0,0,1]]],
				["Land_Sleeping_bag_blue_F", [-3,3,-1.1],[[-1,0,0],[0,0,1]]],
				["Land_Sleeping_bag_brown_F", [-3,2,-1.1],[[-1,0,0],[0,0,1]]],
				["Land_Sleeping_bag_brown_F", [-3,1,-1.1],[[-1,0,0],[0,0,1]]],
				["Land_Sleeping_bag_blue_F", [-3,0,-1.1],[[-1,0,0],[0,0,1]]],
				["Land_Sleeping_bag_blue_F", [-3,-1,-1.1],[[-1,0,0],[0,0,1]]],
				["Land_ClutterCutter_large_F", [0,0,0],[[0,1,0],[0,0,1]]],
				["Land_LuggageHeap_02_F", [-4,-3,-0.8],[[-1,0,0],[0,0,1]]],
				["FirePlace_burning_F", [0,0,-1.05],[[0,1,0],[0,0,1]]]
			  ];
	};
	
	//barracks lvl 2
	case "barracks2":	
	{ 
		_anchorType = "Land_Slum_House02_F";
		_constType = "barracks";
		_level = 2;
		_objs= [												
				["Land_TablePlastic_01_F", [4.5,0,-0.6],[[1,0,0],[0,0,1]]],
				["Land_BakedBeans_F", [4.7,0.4,-0.1], [[1,-1,0],[0,0,1]]],
				["Land_GasCooker_F", [4.6,0,-0.06],[[1,-1,0],[0,0,1]]],
				["Land_BottlePlastic_V2_F", [4.3,0.3,-0.05],[[1,-1,0],[0,0,1]]],
				["Land_CerealsBox_F", [4.8,-0.5,0],[[-1,-1,0],[0,0,1]]],
				["Land_Sleeping_bag_blue_F", [2,3.3,-0.9],[[1,0,0],[0,0,1]]],
				["Land_Sleeping_bag_brown_F", [2,-0.7,-0.9],[[1,0,0],[0,0,1]]],
				["Land_Sleeping_bag_brown_F", [2,2.3,-0.9],[[1,0,0],[0,0,1]]],
				["Land_Sleeping_bag_blue_F", [2,1.3,-0.9],[[1,0,0],[0,0,1]]],
				["Land_Sleeping_bag_blue_F", [2,0.3,-0.9],[[1,0,0],[0,0,1]]],
				["Land_ClutterCutter_large_F", [0,0,0],[[0,1,0],[0,0,1]]],
				["Land_LuggageHeap_02_F", [0,1.3,-0.6],[[1,0,0],[0,0,1]]],
				["Land_cargo_addon01_V2_F", [5,0,0],[[-1,0,0],[0,0,1]]],
				["Land_Camping_Light_F", [0.5,1,1.75],[[1,-1,0],[0,0,1]]],
				["Land_ChairPlastic_F", [6,1,-0.6],[[1,-1,0],[0,0,1]]]
			  ];
	};
	
	//barracks lvl 3
	case "barracks3":	
	{ 
		_anchorType = "Land_Cargo_House_V1_F";
		_constType = "barracks";
		_level = 3;
		_objs= [												
				["Land_Sleeping_bag_blue_F", [2,3.1,0.08],[[0,1,0],[0,0,1]]],
				["Land_Sleeping_bag_brown_F", [1,3.1,0.08],[[0,1,0],[0,0,1]]],
				["Land_Sleeping_bag_brown_F", [-2,3.1,0.08],[[0,1,0],[0,0,1]]],
				["Land_Sleeping_bag_blue_F", [-1,3.1,0.08],[[0,1,0],[0,0,1]]],
				["Land_Sleeping_bag_blue_F", [0,3.1,0.08],[[0,1,0],[0,0,1]]],
				["Land_LuggageHeap_02_F", [2,1,0.2],[[0,1,0],[0,0,1]]],
				["Land_Sink_F", [-1.5,-1,-0.1],[[0,1,0],[0,0,1]]],
				["Land_Camping_Light_F", [0,-0.5,0],[[1,-1,0],[0,0,1]]],
				["Land_Sleeping_bag_blue_folded_F", [-2,1,0],[[1,1,0],[0,0,1]]],
				["Land_Sleeping_bag_brown_folded_F", [-2.5,1,0],[[1,1,0],[0,0,1]]],
				["Land_Ground_sheet_folded_khaki_F", [-2,1.5,0],[[-1,1,0],[0,0,1]]]
			  ];
	};
	
	//vehicle service lvl 1
	case "vehicleService1":	
	{ 
		_anchorType = "Land_cargo_addon02_V1_F";
		_constType = "vehicleservice";
		_level = 1;
		_objs= [												
				["Land_ScrapHeap_1_F", [-4,0,0],[[0,1,0],[0,0,1]]],
				["Land_WorkStand_F", [0,-1.5,-0.7],[[0,1,0],[0,0,1]]],
				["Land_CampingTable_F", [2.5,0,-0.3],[[1,0,0],[0,0,1]]],
				["Land_DrillAku_F", [2.5,-0.5,0.15],[[-1,1,0],[0,1,0]]],
				["Land_ExtensionCord_F", [1,-1.5,0.2],[[0,1,0],[0,0,1]]],
				["Land_Gloves_F", [2.3,0.2,0.12],[[1,-1,0],[0,0,1]]],
				["Land_Grinder_F", [1.7,-1.5,0.23],[[0,1,0],[0,0,1]]],
				["Land_Portable_generator_F", [2.5,1.5,-0.3],[[0,1,0],[0,0,1]]],
				["Land_Meter3m_F", [2.7,0.5,0.15],[[0,1,0],[0,0,1]]],
				["Land_PortableLight_double_F", [-3,-2.5,0.4],[[-1,-1,0],[0,0,1]]],
				["Land_ClutterCutter_large_F", [0,0,0],[[-1,1,0],[0,0,1]]]
			  ];
	};
	
	//vehicle service lvl 1
	case "vehicleService2":	
	{ 
		_anchorType = "Land_cargo_addon02_V1_F";
		_constType = "vehicleservice";
		_level = 2;
		_objs= [												
				["Land_Scrap_MRAP_01_F", [-4.5,0,0.5],[[0,-1,0],[0,0,1]]],
				["Land_WorkStand_F", [0,-1.5,-0.7],[[0,1,0],[0,0,1]]],
				["Land_CampingTable_F", [2.5,0,-0.3],[[1,0,0],[0,0,1]]],
				["Land_DrillAku_F", [2.5,-0.5,0.15],[[-1,1,0],[0,1,0]]],
				["Land_ExtensionCord_F", [1,-1.5,0.2],[[0,1,0],[0,0,1]]],
				["Land_Gloves_F", [2.3,0.2,0.12],[[1,-1,0],[0,0,1]]],
				["Land_Grinder_F", [1.7,-1.5,0.23],[[0,1,0],[0,0,1]]],
				["Land_Portable_generator_F", [2.5,1.5,-0.3],[[0,1,0],[0,0,1]]],
				["Land_Meter3m_F", [2.7,0.5,0.15],[[0,1,0],[0,0,1]]],
				["Land_PortableLight_double_F", [-3,-2.5,0.4],[[-1,-1,0],[0,0,1]]],
				["Land_ClutterCutter_large_F", [0,0,0],[[-1,1,0],[0,0,1]]],
				["Land_cargo_house_slum_F", [5,2,0],[[-1,-1,0],[0,0,1]]],
				["Land_Pallet_MilBoxes_F", [5,2,0],[[-1,-1,0],[0,0,1]]],
				["Land_Pallet_MilBoxes_F", [8,-0.5,0],[[-1,-1,0],[0,0,1]]]
			  ];
	};
};

_buildingObjs = [
					["Land_Pipes_large_F", [-7,0,-1],70],
					["Land_Pallets_stack_F",[7,0,-0.4],70],
					["Land_Bricks_V1_F", [0,7,-1],70],
					["Land_Bricks_V3_F", [0,-7,-1],-70]
                ];

			
//Building anim				
_anchor = "Land_Rampart_F" createVehicle _pos;
waituntil {!isnil "_anchor"};

_builtArray = [_anchor];
_anchor setdir _anchorDir;
s1 = _anchor;

for "_i" from 0 to ((count _buildingObjs) - 1) do
{
	_object = nil;
	_object = ((_buildingObjs select _i) select  0) createVehicle [0,0,0];
	waituntil {!isnil "_object"};
	_object attachTo [_anchor,((_buildingObjs select _i) select  1)]; 
	_object setdir ((getdir _anchor) + ((_buildingObjs select _i) select 2)); 
	_builtArray = _builtArray + [_object];
};

sleep _BuildTime;

{deleteVehicle _x} foreach _builtArray;
sleep 0.5;

//Build object
_anchor = _anchorType createVehicle _pos;
waituntil {!isnil "_anchor"};
_anchor setdir _anchorDir;
_anchor setVariable ["mcc_side",_side,true];

s1 = _anchor;		//TODO Remove

//Build module
_object = MCC_dummyLogicGroup createunit ["Logic", _pos,[],0.5,"NONE"];	
_object setVariable ["mcc_constructionItemType",_constType,true];
_object setVariable ["mcc_constructionItemTypeLevel",_level,true];
_object attachto [_anchor,[0,0,0]];

_anchor AddEventHandler ["HandleDamage", 
							 {
								_obj 		= _this select 0;
								_damage		= _this select 2;
								_source 	= _this select 3;
								_ammo		= _this select 4;
								_side		= _obj getVariable ["mcc_side",sidelogic];
								
								if (_ammo in ["SatchelCharge_Remote_Ammo"] && _damage > 0.6) then 
								{
									
									{detach _x; deleteVehicle _x} foreach attachedObjects _obj;
									_obj setdamage 1;
									[[[_side], {player addRating (if (playerside != (_this select 0)) then {500} else {-1000})}], "BIS_fnc_spawn", _source, false] spawn BIS_fnc_MP;
								} else {0};
							}
						];

for "_i" from 0 to ((count _objs) - 1) do
{
	_object = nil;
	_object = ((_objs select _i) select  0) createVehicle [0,0,0];
	waituntil {!isnil "_object"};
	for "_x" from 1 to 2 do 
	{
		_object attachTo [_anchor,((_objs select _i) select  1)];
		_object setVectorDirAndUp  ((_objs select _i) select  2);
	};
	_object AddEventHandler ["HandleDamage", {}];
};


//_this attachTo [s1,[0,0,0]]; _this setVectorDirAndUp [[0,1,0],[0,0,1]]





