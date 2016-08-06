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

_obj = _this select 0;
_task = _this select 1;
_preciseMarker = _this select 2;
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
   
_pos = if (_preciseMarker) then {getpos _obj} else {[((getpos _obj) select 0) + (random 150 - random 150),((getpos _obj) select 1) + (random 150 - random 150),((getpos _obj) select 2)]};
switch (_task) do
{
   //Hostage
   case "Secure HVT":      
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
      
      _stringDescription =  FORMAT ["Task: Rescue %2. <br/><br/>%1 %2 was captured by enemy forces operating in the area.<br/><br/>%3 we believe that he is held captive <marker name='%5'>%4</marker>.<br/><br/>Find %2 and bring him home.                              
                              "
                             , _missionTime call BIS_fnc_selectRandom
                             , _objectName
                             , _missionIntel call BIS_fnc_selectRandom
                             , _missionWherabouts call BIS_fnc_selectRandom
                             , _stringName
                             ];
      
      //Create A task
      [[8, _stringName, _stringDescription, _pos],"MCC_fnc_makeTaks",true,false] call BIS_fnc_MP;
      
      //Give it public name
      [[[netid _obj,_obj], _name], "MCC_fnc_setVehicleName", true, false] call BIS_fnc_MP;
      
      //---Create A trigger---
      //Fail - not alive
      _capturVar = FORMAT ['[[3, "%1", "", [0,0,0]],"MCC_fnc_makeTaks",true,false] spawn BIS_fnc_MP;',_stringName];
      _stateCond = FORMAT ['!alive %1', _name];
      [0, getpos _obj, [1,1], "NONE", "PRESENT", "RECTANGLE", name _obj, _capturVar,0,2,_stateCond,""] execVM MCC_path + "mcc\general_scripts\triggers\triggers_execute.sqf";
      
      //Succeed - not hostage
      _capturVar = FORMAT ['[[2, "%1", "", [0,0,0]],"MCC_fnc_makeTaks",true,false] spawn BIS_fnc_MP;',_stringName];
      _stateCond = FORMAT ['(isPlayer leader %1) && (alive %1)', _name];
      [0, getpos _obj, [1,1], "NONE", "PRESENT", "RECTANGLE", name _obj, _capturVar,0,2,_stateCond,""] execVM MCC_path + "mcc\general_scripts\triggers\triggers_execute.sqf";
   };

   //Kill
   case "Kill HVT":      
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
      _stringDescription =  FORMAT ["Task: Kill or capture %2. <br/><br/>%3, HQ in their wisdom believe that since %1 %2 has been hiding <marker name='%5'>%4</marker>.<br/><br/>%2 is a most wanted HVT and should be considered armed and dangerous.<br/><br/>Capture him if possible, if not kill him. Either way, don't let him escape."
                             , _missionTime call BIS_fnc_selectRandom
                             , _objectName
                             , _missionIntel call BIS_fnc_selectRandom
                             , _missionWherabouts call BIS_fnc_selectRandom
                             , _stringName
                             ];

      //Create A task
      [[8, _stringName, _stringDescription, _pos],"MCC_fnc_makeTaks",true,false] call BIS_fnc_MP;

      //Give it public name
      [[[netid _obj,_obj], _name], "MCC_fnc_setVehicleName", true, false] call BIS_fnc_MP;

      //---Create A trigger---
      //Succeed alive
      _capturVar = FORMAT ['[[2, "%1", "", [0,0,0]],"MCC_fnc_makeTaks",true,false] spawn BIS_fnc_MP;',_stringName];
      _stateCond = FORMAT ['!alive %1 || (isplayer (leader group %1))', _name];
      [0, getpos _obj, [1,1], "NONE", "PRESENT", "RECTANGLE", name _obj, _capturVar,0,2,_stateCond,""] execVM MCC_path + "mcc\general_scripts\triggers\triggers_execute.sqf";
   };
   
   //destroy_tanks
   case "destroy_tanks":      
   {
      _objectName = getText(configFile >> "CfgVehicles" >> typeof _obj >> "displayname");
      _stringName   = FORMAT ["%2 Destroy the prototype %1", _objectName,_nameTask];
      _stringDescription =  FORMAT ["Task: Destroy the prototype %2.<br/><br/>%1 HQ received intel suggesting that the enemy has obtained a prototype %2.<br/><br/>This is a game-changer and we must eliminate it by any means necessary.<br/>%3 the vehicle is hidden <marker name='%5'>%4.</marker>"
                             , _missionTime call BIS_fnc_selectRandom
                             , _objectName
                             , _missionIntel call BIS_fnc_selectRandom
                             , _missionWherabouts call BIS_fnc_selectRandom
                             , _stringName
                             ];
      
      //Create A task
      [[8, _stringName, _stringDescription, _pos],"MCC_fnc_makeTaks",true,false] call BIS_fnc_MP;
      
      //Give it public name
      [[[netid _obj,_obj], _name], "MCC_fnc_setVehicleName", true, false] call BIS_fnc_MP;
      
      //---Create A trigger---
      //Succeed alive
      _capturVar = FORMAT ['[[2, "%1", "", [0,0,0]],"MCC_fnc_makeTaks",true,false] spawn BIS_fnc_MP;',_stringName];
      _stateCond = FORMAT ['!alive %1', _name];
      [0, getpos _obj, [1,1], "NONE", "PRESENT", "RECTANGLE", name _obj, _capturVar,0,2,_stateCond,""] execVM MCC_path + "mcc\general_scripts\triggers\triggers_execute.sqf";
   };
   
   //destroy_aa
   case "destroy_aa":      
   {
      _objectName = getText(configFile >> "CfgVehicles" >> typeof _obj >> "displayname");
      _stringName   = FORMAT ["%2 Destroy %1", _objectName,_nameTask];
      _stringDescription =  FORMAT ["Task: Destroy %2.<br/><br/>%1 one of our planes got shot down.<br/>HQ believes that a %2 is behind it.<br/><br/>This threat must be eliminated.<br/><br/>%3 the AA is operating <marker name='%5'>%4</marker>. Find and destroy it, soldier."
                             , _missionTime call BIS_fnc_selectRandom
                             , _objectName
                             , _missionIntel call BIS_fnc_selectRandom
                             , _missionWherabouts call BIS_fnc_selectRandom
                             , _stringName
                             ];
      
      //Create A task
      [[8, _stringName, _stringDescription, _pos],"MCC_fnc_makeTaks",true,false] call BIS_fnc_MP;
      
      //Give it public name
      [[[netid _obj,_obj], _name], "MCC_fnc_setVehicleName", true, false] call BIS_fnc_MP;
      
      //---Create A trigger---
      //Succeed alive
      _capturVar = FORMAT ['[[2, "%1", "", [0,0,0]],"MCC_fnc_makeTaks",true,false] spawn BIS_fnc_MP;',_stringName];
      _stateCond = FORMAT ['!alive %1', _name];
      [0, getpos _obj, [1,1], "NONE", "PRESENT", "RECTANGLE", name _obj, _capturVar,0,2,_stateCond,""] execVM MCC_path + "mcc\general_scripts\triggers\triggers_execute.sqf";
   };
   
   //destroy_artillery
   case "destroy_artillery":      
   {
      _objectName = getText(configFile >> "CfgVehicles" >> typeof _obj >> "displayname");
      _stringName   = FORMAT ["%2 Destroy %1", _objectName,_nameTask];
      _stringDescription =  FORMAT ["Task: Destroy %2.<br/><br/>%1 enemy artillery began pounding our troops. This threat must be eliminated.<br/><br/>%3 the %2 is operating <marker name='%5'>%4</marker>.<br/><br/>Find and destroy it ASAP."
                             , _missionTime call BIS_fnc_selectRandom
                             , _objectName
                             , _missionIntel call BIS_fnc_selectRandom
                             , _missionWherabouts call BIS_fnc_selectRandom
                             , _stringName
                             ];
      
      //Create A task
      [[8, _stringName, _stringDescription, _pos],"MCC_fnc_makeTaks",true,false] call BIS_fnc_MP;
      
      //Give it public name
      [[[netid _obj,_obj], _name], "MCC_fnc_setVehicleName", true, false] call BIS_fnc_MP;
      
      //---Create A trigger---
      //Succeed alive
      _capturVar = FORMAT ['[[2, "%1", "", [0,0,0]],"MCC_fnc_makeTaks",true,false] spawn BIS_fnc_MP;',_stringName];
      _stateCond = FORMAT ['!alive %1', _name];
      [0, getpos _obj, [1,1], "NONE", "PRESENT", "RECTANGLE", name _obj, _capturVar,0,2,_stateCond,""] execVM MCC_path + "mcc\general_scripts\triggers\triggers_execute.sqf";
   };
   
   //destroy_cache
   case "destroy_cache":      
   {
      _stringName   =FORMAT ["%1 Destroy the enemy weapons cache",_nameTask];
      _stringDescription =  FORMAT ["Task: Destroy the enemy weapons cache.<br/><br/>%2 received %1, we believe that the enemy is hiding a weapons cache <marker name='%4'>%3</marker>.<br/><br/>Destroying it will severely damage the enemy war effort.<br/><br/>Find and destroy it ASAP."
                             , _missionTime call BIS_fnc_selectRandom
                             , _missionIntel call BIS_fnc_selectRandom
                             , _missionWherabouts call BIS_fnc_selectRandom
                             , _stringName
                             ];
      
      //Create A task
      [[8, _stringName, _stringDescription, _pos],"MCC_fnc_makeTaks",true,false] call BIS_fnc_MP;
      
      //Give it public name
      [[[netid _obj,_obj], _name], "MCC_fnc_setVehicleName", true, false] call BIS_fnc_MP;
      
      //---Create A trigger---
      //Succeed alive
      _capturVar = FORMAT ['[[2, "%1", "", [0,0,0]],"MCC_fnc_makeTaks",true,false] spawn BIS_fnc_MP;',_stringName];
      _stateCond = FORMAT ['!alive %1', _name];
      [0, getpos _obj, [1,1], "NONE", "PRESENT", "RECTANGLE", name _obj, _capturVar,0,2,_stateCond,""] execVM MCC_path + "mcc\general_scripts\triggers\triggers_execute.sqf";
   };
   
   //destroy_fuel
   case "destroy_fuel":      
   {
      _stringName   = FORMAT ["%1 Destroy the enemy fuel depot",_nameTask];
      _stringDescription =  FORMAT ["Task: Destroy the enemy fuel depot.<br/><br/>%2 received %1, we believe that the enemy have a fuel depot <marker name='%4'>%3</marker>.<br/><br/>Destroying it will severely damage the enemy war effort.<br/><br/>Find and destroy it ASAP."
                             , _missionTime call BIS_fnc_selectRandom
                             , _missionIntel call BIS_fnc_selectRandom
                             , _missionWherabouts call BIS_fnc_selectRandom
                             , _stringName
                             ];
      
      //Create A task
      [[8, _stringName, _stringDescription, _pos],"MCC_fnc_makeTaks",true,false] call BIS_fnc_MP;
      
      //Give it public name
      [[[netid _obj,_obj], _name], "MCC_fnc_setVehicleName", true, false] call BIS_fnc_MP;
      
      //---Create A trigger---
      //Succeed alive
      _capturVar = FORMAT ['[[2, "%1", "", [0,0,0]],"MCC_fnc_makeTaks",true,false] spawn BIS_fnc_MP;',_stringName];
      _stateCond = FORMAT ['!alive %1', _name];
      [0, getpos _obj, [1,1], "NONE", "PRESENT", "RECTANGLE", name _obj, _capturVar,0,2,_stateCond,""] execVM MCC_path + "mcc\general_scripts\triggers\triggers_execute.sqf";
   };
   
   //destroy_radio
   case "destroy_radio":      
   {
      _stringName   = FORMAT ["%1 Destroy the enemy radio tower",_nameTask];
      _stringDescription =  FORMAT ["Task: Destroy the enemy radio tower.<br/><br/>%2 received %1 the enemy have a radio tower <marker name='%4'>%3</marker>. They are using it to coordinate their attacks.<br/><br/>Destroying it will severely damage the enemy war effort.<br/><br/>Find and destroy it ASAP."
                             , _missionTime call BIS_fnc_selectRandom
                             , _missionIntel call BIS_fnc_selectRandom
                             , _missionWherabouts call BIS_fnc_selectRandom
                             , _stringName
                             ];
      
      //Create A task
      [[8, _stringName, _stringDescription, _pos],"MCC_fnc_makeTaks",true,false] call BIS_fnc_MP;
      
      //Give it public name
      [[[netid _obj,_obj], _name], "MCC_fnc_setVehicleName", true, false] call BIS_fnc_MP;
      
      //---Create A trigger---
      //Succeed alive
      _capturVar = FORMAT ['[[2, "%1", "", [0,0,0]],"MCC_fnc_makeTaks",true,false] spawn BIS_fnc_MP;',_stringName];
      _stateCond = FORMAT ['!alive %1', _name];
      [0, getpos _obj, [1,1], "NONE", "PRESENT", "RECTANGLE", name _obj, _capturVar,0,2,_stateCond,""] execVM MCC_path + "mcc\general_scripts\triggers\triggers_execute.sqf";
   };
   
   //destroy_radar
   case "destroy_radar":      
   {
      _stringName   = FORMAT ["%1 Destroy the enemy radar",_nameTask];
      _stringDescription =  FORMAT ["Task: Destroy the enemy radar.<br/><br/>%2 received %1 the enemy have a radar installation <marker name='%4'>%3</marker>. They are using it to pinpoint the location of our troops.<br/><br/>By destroying it we can regain the element of surprise.<br/><br/>Find and destroy it ASAP."
                             , _missionTime call BIS_fnc_selectRandom
                             , _missionIntel call BIS_fnc_selectRandom
                             , _missionWherabouts call BIS_fnc_selectRandom
                             , _stringName
                             ];
      
      //Create A task
      [[8, _stringName, _stringDescription, _pos],"MCC_fnc_makeTaks",true,false] call BIS_fnc_MP;
      
      //Give it public name
      [[[netid _obj,_obj], _name], "MCC_fnc_setVehicleName", true, false] call BIS_fnc_MP;
      
      //---Create A trigger---
      //Succeed alive
      _capturVar = FORMAT ['[[2, "%1", "", [0,0,0]],"MCC_fnc_makeTaks",true,false] spawn BIS_fnc_MP;',_stringName];
      _stateCond = FORMAT ['!alive %1', _name];
      [0, getpos _obj, [1,1], "NONE", "PRESENT", "RECTANGLE", name _obj, _capturVar,0,2,_stateCond,""] execVM MCC_path + "mcc\general_scripts\triggers\triggers_execute.sqf";
   };
   
   //pick_intel
   case "pick_intel":      
   {
      _objectName = getText(configFile >> "CfgVehicles" >> typeof _obj >> "displayname");
      _stringName   = FORMAT ["%2 Acquire the %1", _objectName,_nameTask];
      _stringDescription =  FORMAT ["Task: Acquire Intel.<br/><br/>HQ believe that we have an opportunity to acquire top notch information about enemy forces operating in the area.<br/><br/>%3 the target data is in a %2, located <marker name='%5'>%4</marker>.<br/><br/>Retrieve the information and bring it back for analysis."
                             , _missionTime call BIS_fnc_selectRandom
                             , _objectName
                             , _missionIntel call BIS_fnc_selectRandom
                             , _missionWherabouts call BIS_fnc_selectRandom
                             , _stringName
                             ];
      
      //Create A task
      [[8, _stringName, _stringDescription, _pos],"MCC_fnc_makeTaks",true,false] call BIS_fnc_MP;
      
      //Give it public name
      [[[netid _obj,_obj], _name], "MCC_fnc_setVehicleName", true, false] call BIS_fnc_MP;
      
      //---Create A trigger---
      _capturVar = FORMAT ['[[2, "%1", "", [0,0,0]],"MCC_fnc_makeTaks",true,false] spawn BIS_fnc_MP;',_stringName];
      _stateCond = FORMAT ['!alive %1', _name];
      [0, getpos _obj, [1,1], "NONE", "PRESENT", "RECTANGLE", name _obj, _capturVar,0,2,_stateCond,""] execVM MCC_path + "mcc\general_scripts\triggers\triggers_execute.sqf";
   };
   
   //clear_area
   case "clear_area":      
   {
      _stringName   = FORMAT ["%1 Capture and Hold",_nameTask];
      _stringDescription =  FORMAT ["Task: Capture and Hold.<br/><br/>%1 enemy forces established a foothold <marker name='%3'>%2</marker>.<br/><br/>We can't allow this to continue!<br/><br/>Go there and kick them out!!"
                             , _missionTime call BIS_fnc_selectRandom
                             , _missionWherabouts call BIS_fnc_selectRandom
                             , _stringName
                             ];
      
      //Create A task
      [[8, _stringName, _stringDescription, _pos],"MCC_fnc_makeTaks",true,false] call BIS_fnc_MP;
      
      //Give it public name
      [[[netid _obj,_obj], _name], "MCC_fnc_setVehicleName", true, false] call BIS_fnc_MP;
      
      //---Create A trigger---
      _capturVar = FORMAT ['[[2, "%1", "", [0,0,0]],"MCC_fnc_makeTaks",true,false] spawn BIS_fnc_MP;',_stringName];
      _stateCond = FORMAT ['!alive %1', _name];
      [0, getpos _obj, [1,1], "NONE", "PRESENT", "RECTANGLE", name _obj, _capturVar,0,2,_stateCond,""] execVM MCC_path + "mcc\general_scripts\triggers\triggers_execute.sqf";
   };
   
   //disableIED
   case "disableIED":   
   {
      _stringName   = FORMAT ["%1 Disable IED",_nameTask];
      _stringDescription =  FORMAT ["Task: Disable IED.<br/><br/>%1 enemy forces have placed a massive Improvised Explosive Device (IED) on a road <marker name='%3'>%2</marker>.<br/><br/>We must disable it before it can cause any damage.<br/><br/>Tread carefully, find the IED and disarm it."   
                             , _missionIntel call BIS_fnc_selectRandom
                             , _missionWherabouts call BIS_fnc_selectRandom
                             , _stringName
                             ];
      
      //Create A task
      [[8, _stringName, _stringDescription, _pos],"MCC_fnc_makeTaks",true,false] call BIS_fnc_MP;
      
      //Give it public name
      [[[netid _obj,_obj], _name], "MCC_fnc_setVehicleName", true, false] call BIS_fnc_MP;
      
      //---Create A trigger---
      _capturVar = FORMAT ['[[2, "%1", "", [0,0,0]],"MCC_fnc_makeTaks",true,false] spawn BIS_fnc_MP;',_stringName];
      _stateCond = FORMAT ['!alive %1', _name];
      [0, getpos _obj, [1,1], "NONE", "PRESENT", "RECTANGLE", _name, _capturVar,0,2,_stateCond,""] execVM MCC_path + "mcc\general_scripts\triggers\triggers_execute.sqf";
   };
};   
MCC_MWObjectivesNames = [_pos,"",_stringName,_stringDescription,"","",1,[]];
publicVariable "MCC_MWObjectivesNames";

