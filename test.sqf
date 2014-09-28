//player addaction ["<t color='#FFCC00'>Construction</t>","test.sqf",["Arti_dlg"],-1,false,true,"","vehicle _target == vehicle _this"];
//
/*
private ["_dummy","_dummyGroup","_name"]; 

["Land_Medevac_house_V1_F",getpos player,true] call MCC_3D_PLACER;

_pos = position player;
_name = format ["MCC_curator%1", playerside];

//TODO remove it for testing only
if (!isnil _name) then {deleteVehicle MCC_curatorWest; MCC_curatorWest = nil};
sleep 1; 

if (isnil _name) then			//TODO - Move to server player side should inharit
{
	//CURATOR
	_dummyGroup = creategroup sideLogic; 
	_dummy = _dummyGroup createunit ["ModuleCurator_F", _pos,[],0.5,"NONE"];	//Logic Server
	_dummy setvariable ["text",_name];
	_dummy setvariable ["mccIgnore",true];
	
	
	//Limit
	_dummy addCuratorCameraArea [3,position _dummy,20];
	_dummy addCuratorEditingArea [4,position _dummy,20];
	
	_dummy allowCuratorLogicIgnoreAreas false;
	_dummy setCuratorCameraAreaCeiling 50;
	_dummy setCuratorEditingAreaType true;
		
	_dummy addCuratorAddons [
								"a3_air_f",
								"A3_Modules_F_Curator_Animals",
								"A3_Modules_F_Curator_CAS",
								"A3_Modules_F_Curator_Chemlights",
								"ModuleCuratorSetAttributesObject_F",
								"ModuleCuratorSetAttributesPlayer_F",
								"ModuleCuratorSetAttributesGroup_F",
								"ModuleCuratorSetAttributesWaypoint_F",
								"ModuleCuratorSetAttributesMarker_F",
								"A3_Modules_F_Curator_Effects",
								"A3_Modules_F_Curator_Environment",
								"A3_Modules_F_Curator_Environment"								
							   ];
	
	_dummy addEventHandler [
		"CuratorObjectRegistered",
		{
			_classes = _this select 1;
			_costs = [];
			{
				_cost = if (_x isKindOf "Man") then {[true,0.1]} else {[false,0]}; // Show only objects of type "Man", hide everything else
				_costs = _costs + [_cost];
			} forEach _classes; // Go through all classes and assign cost for each of them
			_costs
		}
	];
	
	
	call compile (_name + " = _dummy");
	publicVariable _name;
	
	sleep 1; 
	_dummy addCuratorAddons [];
};

//MCC_curatorWest addCuratorPoints 0.5
//TODO - Move to server player side and player should inharit regain MCC curator later
if (getAssignedCuratorLogic player == MCC_curator) then
{
	unassignCurator MCC_curator;
};

player assignCurator call compile format ["MCC_curator%1", playerside]; 
while {alive _dummy} do 
{
	_obj = (getpos _dummy nearObjects 25);
	{
		player sidechat typeOF _x;
		sleep 2;
	} foreach _obj
};

*/