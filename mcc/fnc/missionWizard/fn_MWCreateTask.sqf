//======================================================MCC_fnc_MWCreateTask=========================================================================================================
// Find the mission Wizard's center
// Example:[_obj,_task,_preciseMarker] call MCC_fnc_MWCreateTask; 
// _obj = position, objectice position
//_task = string, objective type
//_preciseMarker = Boolean, true - precise task marker
// Return - [taskName,Task pos]
//========================================================================================================================================================================================
private ["_obj","_task","_preciseMarker","_type","_stringName","_stringDescription","_pos","_objectName","_missionTime","_missionIntel","_indecator","_capturVar",
      "_stateCond","_name","_missionWherabouts"];

_obj 			= _this select 0;
_task 			= _this select 1;
_preciseMarker 	= _this select 2;

_name = FORMAT ["MCCMWObject_%1", ["MCCMWObject_",1] call bis_fnc_counter]; 
_nameTask = FORMAT ["Objective %1:", ["",1] call bis_fnc_counter]; 
//Global defines for briefings.    
_missionTime = 
   [
     "This morning",
     "Last night",
     "Yesterday",
     "A few days ago",
     "Last week"
   ];
   
_missionIntel = 
   [
     "From gathered intel",
     "According to satellite photos",
     "According to intel from a local informant",
     "According to info from High Command"
   ];

_missionWherabouts = 
   [
      "in this location",
      "in this area", 
      "somewhere in this area", 
      "close to this location",
      "around here"
   ];

_pos = if (typeName _obj == "OBJECT") then {getpos _obj} else {_obj}; 
 
if !(_preciseMarker) then 
{
	_pos =  [(_pos select 0) + (random 300 - random 300),(_pos select 1) + (random 300 - random 300),(_pos select 2)];
};
		
switch (_task) do
{
   //Hostage
   case "Secure_HVT":      
   {
      if (side _obj != civilian) then
      {
         _objectName = ([_obj,"displayName"] call BIS_fnc_rankParams) + " " + name _obj; 
      } 
      else
      {
         _objectName = name _obj; 
      }; 
   
      _stringName   = FORMAT ["%2 Rescue %1", _objectName,_nameTask];
      
      _stringDescription =  FORMAT ["Task: Rescue %2. <br/><br/>%1 %2 was captured by enemy forces operating in the area.<br/>%3 we believe that he is held captive %4.<br/>Find %2 and bring him home.                              
                              "
                             , _missionTime call BIS_fnc_selectRandom
                             , _objectName
                             , _missionIntel call BIS_fnc_selectRandom
                             , _missionWherabouts call BIS_fnc_selectRandom
                             , _stringName
                             ];
   };

   //Kill
   case "Kill_HVT":      
   {
      if (side _obj != civilian) then
      {
         _objectName = ([_obj,"displayName"] call BIS_fnc_rankParams) + " " + name _obj; 
      } 
      else
      {
         _objectName = name _obj; 
      }; 

      _stringName   = FORMAT ["%2 Kill or capture %1", _objectName,_nameTask];
      _stringDescription =  FORMAT ["Task: Kill or capture %2. <br/><br/>%3, HQ in their wisdom believe that since %1 %2 has been hiding %4.<br/>%2 is a most wanted HVT and should be considered armed and dangerous.<br/>Capture him if possible, if not kill him. Either way, do not let him escape."
                             , _missionTime call BIS_fnc_selectRandom
                             , _objectName
                             , _missionIntel call BIS_fnc_selectRandom
                             , _missionWherabouts call BIS_fnc_selectRandom
                             , _stringName
							];
   };
   
   //destroy_tanks
   case "destroy_tanks":      
   {
      _objectName = getText(configFile >> "CfgVehicles" >> typeof _obj >> "displayname");
      _stringName   = FORMAT ["%2 Destroy the prototype %1", _objectName,_nameTask];
      _stringDescription =  FORMAT ["Task: Destroy the prototype %2.<br/><br/>%1 HQ received intel suggesting that the enemy has obtained a prototype %2.<br/>This is a game-changer and we must eliminate it by any means necessary.<br/>%3 the vehicle is hidden %4."
                             , _missionTime call BIS_fnc_selectRandom
                             , _objectName
                             , _missionIntel call BIS_fnc_selectRandom
                             , _missionWherabouts call BIS_fnc_selectRandom
                             , _stringName
                             ];
   };
   
   //destroy_aa
   case "destroy_aa":      
   {
      _objectName = getText(configFile >> "CfgVehicles" >> typeof _obj >> "displayname");
      _stringName   = FORMAT ["%2 Destroy %1", _objectName,_nameTask];
      _stringDescription =  FORMAT ["Task: Destroy %2.<br/><br/>%1 one of our planes got shot down.<br/>HQ believes that a %2 is behind it.<br/>This threat must be eliminated.<br/>%3 the AA is operating %4. Find and destroy it, soldier."
                             , _missionTime call BIS_fnc_selectRandom
                             , _objectName
                             , _missionIntel call BIS_fnc_selectRandom
                             , _missionWherabouts call BIS_fnc_selectRandom
                             , _stringName
                             ];
   };
   
   //destroy_artillery
   case "destroy_artillery":      
   {
      _objectName = getText(configFile >> "CfgVehicles" >> typeof _obj >> "displayname");
      _stringName   = FORMAT ["%2 Destroy %1", _objectName,_nameTask];
      _stringDescription =  FORMAT ["Task: Destroy %2.<br/><br/>%1 enemy artillery began pounding our troops. This threat must be eliminated.<br/>%3 the %2 is operating %4.<br/>Find and destroy it ASAP."
                             , _missionTime call BIS_fnc_selectRandom
                             , _objectName
                             , _missionIntel call BIS_fnc_selectRandom
                             , _missionWherabouts call BIS_fnc_selectRandom
                             , _stringName
                             ];
   };
   
   //destroy_cache
   case "destroy_cache":      
   {
      _stringName   =FORMAT ["%1 Destroy the enemy weapons cache",_nameTask];
      _stringDescription =  FORMAT ["Task: Destroy the enemy weapons cache.<br/><br/>%2 received %1, we believe that the enemy is hiding a weapons cache %3.<br/>Destroying it will severely damage the enemy war effort.<br/>Find and destroy it ASAP."
                             , _missionTime call BIS_fnc_selectRandom
                             , _missionIntel call BIS_fnc_selectRandom
                             , _missionWherabouts call BIS_fnc_selectRandom
                             , _stringName
                             ];
      
   };

   //destroy_fuel
   case "destroy_fuel":      
   {
      _stringName   = FORMAT ["%1 Destroy the enemy fuel depot",_nameTask];
      _stringDescription =  FORMAT ["Task: Destroy the enemy fuel depot.<br/><br/>%2 received %1, we believe that the enemy have a fuel depot %3.<br/>Destroying it will severely damage the enemy war effort.<br/>Find and destroy it ASAP."
                             , _missionTime call BIS_fnc_selectRandom
                             , _missionIntel call BIS_fnc_selectRandom
                             , _missionWherabouts call BIS_fnc_selectRandom
                             , _stringName
                             ];
      
   };
   
   //destroy_radio
   case "destroy_radio":      
   {
      _stringName   = FORMAT ["%1 Destroy the enemy radio tower",_nameTask];
      _stringDescription =  FORMAT ["Task: Destroy the enemy radio tower.<br/><br/>%2 received %1 the enemy have a radio tower %3. They are using it to coordinate their attacks.<br/>Destroying it will severely damage the enemy war effort.<br/>Find and destroy it ASAP."
                             , _missionTime call BIS_fnc_selectRandom
                             , _missionIntel call BIS_fnc_selectRandom
                             , _missionWherabouts call BIS_fnc_selectRandom
                             , _stringName
                             ];
   };
   
   //destroy_radar
   case "destroy_radar":      
   {
      _stringName   = FORMAT ["%1 Destroy the enemy radar",_nameTask];
      _stringDescription =  FORMAT ["Task: Destroy the enemy radar.<br/><br/>%2 received %1 the enemy have a radar installation %3. They are using it to pinpoint the location of our troops.<br/>By destroying it we can regain the element of surprise.<br/>Find and destroy it ASAP."
                             , _missionTime call BIS_fnc_selectRandom
                             , _missionIntel call BIS_fnc_selectRandom
                             , _missionWherabouts call BIS_fnc_selectRandom
                             , _stringName
                             ];
   };
   
   //pick_intel
   case "pick_intel":      
   {
      _objectName = getText(configFile >> "CfgVehicles" >> typeof _obj >> "displayname");
      _stringName   = FORMAT ["%2 Acquire the %1", _objectName,_nameTask];
      _stringDescription =  FORMAT ["Task: Acquire Intel.<br/><br/>HQ believe that we have an opportunity to acquire top notch information about enemy forces operating in the area.<br/>%3 the target data is in a %2, located %4.<br/>Retrieve the information and bring it back for analysis."
                             , _missionTime call BIS_fnc_selectRandom
                             , _objectName
                             , _missionIntel call BIS_fnc_selectRandom
                             , _missionWherabouts call BIS_fnc_selectRandom
                             , _stringName
                             ];
   };
   
   //clear_area
   case "clear_area":      
   {
      _stringName   = FORMAT ["%1 Capture and Hold",_nameTask];
      _stringDescription =  FORMAT ["Task: Capture and Hold.<br/><br/>%1 enemy forces established a foothold %2.<br/>We can not allow this to continue!<br/>Go there and kick them out!!"
                             , _missionTime call BIS_fnc_selectRandom
                             , _missionWherabouts call BIS_fnc_selectRandom
                             , _stringName
                             ];
   };
   
   //disableIED
   case "disableIED":   
   {
      _stringName   = FORMAT ["%1 Disable IED",_nameTask];
      _stringDescription =  FORMAT ["Task: Disable IED.<br/><br/>%1 enemy forces have placed a massive Improvised Explosive Device (IED) on a road %2.<br/>We must disable it before it can cause any damage.<br/>Tread carefully, find the IED and disarm it."   
                             , _missionIntel call BIS_fnc_selectRandom
                             , _missionWherabouts call BIS_fnc_selectRandom
                             , _stringName
                             ];
   };
};   

private ["_group","_vehicle"];

//If it is a clear area task
if (_task in ["clear_area"]) then
{
	
	
	_group = createGroup sidelogic;
	
	_vehicle =  _group createunit ["ModuleObjective_F", _pos,[],0.5,"NONE"]; 
	_vehicle setvariable ["RscAttributeOwners",[west,east,resistance,civilian],true]; 
	_vehicle setvariable ["RscAttributeTaskState","created", true];
	_vehicle setvariable ["customTask",_task,true];
	[_vehicle,"RscAttributeTaskDescription",[_stringDescription,_stringName,_stringName]] call bis_fnc_setServerVariable;
	MCC_curator addCuratorEditableObjects [[_vehicle],false]; 
	_vehicle setvariable ["updated",true];
	[_vehicle] spawn MCC_fnc_customTasks; 
};

//If it is a custom task
if (_task in ["Secure_HVT","Kill_HVT","pick_intel","disableIED"]) then
{
	_group = createGroup sidelogic;
	
	_vehicle =  _group createunit ["ModuleObjective_F", _pos,[],0.5,"NONE"]; 
	_vehicle setvariable ["RscAttributeOwners",[west,east,resistance,civilian],true]; 
	_vehicle setvariable ["bis_fnc_curatorAttachObject_object",_obj,true];
	_vehicle setvariable ["RscAttributeTaskState","created", true];
	_vehicle setvariable ["customTask",_task,true];
	[_vehicle,"RscAttributeTaskDescription",[_stringDescription,_stringName,_stringName]] call bis_fnc_setServerVariable;
	MCC_curator addCuratorEditableObjects [[_vehicle],false]; 
	_vehicle setvariable ["updated",true];
	[_vehicle] spawn MCC_fnc_customTasks; 
};

//If it is a destroy task
if (_task in ["destroy_tanks","destroy_aa","destroy_artillery","destroy_cache","destroy_fuel","destroy_radio","destroy_radar"]) then
{
	_group = createGroup sidelogic;
	
	_vehicle =  _group createunit ["ModuleObjectiveNeutralize_F", _pos,[],0.5,"NONE"]; 
	_vehicle setvariable ["RscAttributeOwners",[west,east,resistance,civilian],true]; 
	_vehicle setvariable ["bis_fnc_curatorAttachObject_object",_obj,true];
	[_vehicle,"RscAttributeTaskDescription",[_stringDescription,_stringName,_stringName]] call bis_fnc_setServerVariable;
	MCC_curator addCuratorEditableObjects [[_vehicle],false]; 
	_vehicle setvariable ["updated",true];
};

MCC_MWObjectivesNames = [_pos,"",_stringName,_stringDescription,"","",1,[],_vehicle];
publicVariable "MCC_MWObjectivesNames";

