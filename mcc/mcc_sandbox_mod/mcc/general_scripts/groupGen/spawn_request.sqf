//Made by Shay_Gman (c) 09.10
#define groupGen_IDD 2994

#define MCC_GroupGenCurrentGroup_IDD 9003
#define MCC_GroupGenWPType_IDD 9004
#define MCC_GroupGenWPConbatMode_IDD 9005
#define MCC_GroupGenWPFormation_IDD 9006
#define MCC_GroupGenWPSpeed_IDD 9007
#define MCC_GroupGenWPBehavior_IDD 9008
#define MCC_GroupGenWPcondition_IDD 9009
#define MCC_GroupGenGroups_IDD 9010
#define MCC_WPTimeout_IDD 9011
#define MCC_GroupGenWPStatment_IDD 9012

private ["_type", "_comboBox", "_mccdialog", "_displayname","_index","_wpType","_wpComabt","_wpFormation","_wpSpeed","_wpBehavior","_dlg","_nul",
		 "_wpText","_wpTextStatement","_wpTimOut"];
disableSerialization;

_mccdialog = findDisplay groupGen_IDD;
_type = _this select 0;
_dlg = findDisplay groupGen_IDD;
if !mcc_isloading then	{
	if (_type==0) then	{										//Spawn Group
			MCC_groupGenGroupcount = MCC_groupGenGroupcount +1;
			hint "click on the map"; 
			onMapSingleClick " 	hint ""Group Spawned."";
							mcc_safe = mcc_safe + FORMAT ['
										[[%1 , %2, %3, %4],""MCC_fnc_groupSpawn"",true,false] spawn BIS_fnc_MP;
										sleep 1;'								 
										, _pos
										, MCC_groupGenCurrenGroupArray
										, MCC_groupGenGroupcount
										, mcc_hc
										];
							[[_pos, MCC_groupGenCurrenGroupArray, MCC_groupGenGroupcount, mcc_hc],'MCC_fnc_groupSpawn',true,false] spawn BIS_fnc_MP;
							onMapSingleClick """";";
			_nul=[MCC_groupGenGroupStatus] execVM MCC_path + "mcc\general_scripts\groupGen\group_manage.sqf";	//Refresh the group WP
		};
		
	if (_type==1) then	{											//Add WP
		if (count MCC_groupGenGroupArray > 0) then {				//Fali safe if no group selected
			_wpType = lbCurSel MCC_GroupGenWPType_IDD;
			_wpComabt = ["NO CHANGE", "BLUE", "GREEN", "WHITE", "YELLOW", "RED"] select (lbCurSel MCC_GroupGenWPConbatMode_IDD);
			_wpFormation = ["NO CHANGE", "COLUMN", "STAG COLUMN", "WEDGE", "ECH LEFT", "ECH RIGHT", "VEE", "LINE", "FILE", "DIAMOND"] select (lbCurSel MCC_GroupGenWPFormation_IDD);
			_wpSpeed = ["UNCHANGED", "LIMITED", "NORMAL", "FULL"] select (lbCurSel MCC_GroupGenWPSpeed_IDD);
			_wpBehavior = ["UNCHANGED", "CARELESS", "SAFE", "AWARE", "COMBAT", "STEALTH"] select (lbCurSel MCC_GroupGenWPBehavior_IDD);
			_wpText = ctrlText (_dlg displayCtrl MCC_GroupGenWPStatment_IDD);
			_wpTextStatement = ctrlText (_dlg displayCtrl MCC_GroupGenWPStatment_IDD);
			_wpTimOut = [0,5,10,15,20,30,60,90,120,180,240,300,360,420,480,540,600,660,720,780,840,900,960,1020,1080,1140,1200] select (lbCurSel MCC_WPTimeout_IDD);
			MCC_WpGenarray = [_wpType, _wpComabt,_wpFormation,_wpSpeed,_wpBehavior,_wpText,_wpTextStatement,_wpTimOut];
			MCC_groupGenGroupWP = MCC_groupGenGroupArray select (lbCurSel MCC_GroupGenGroups_IDD);
			MCC_WPgenMapClick = false; 	
			hint "click on the map"; 
				onMapSingleClick " 	hint ""WP Added."";
									[[0,_pos, MCC_WpGenarray, [MCC_groupGenGroupWP]],'MCC_fnc_manageWp',true,false] call BIS_fnc_MP;
									MCC_WPgenMapClick = true; 	
									onMapSingleClick """";";	
			waituntil {MCC_WPgenMapClick}; 
			sleep 1; 
			(_mccdialog displayCtrl MCC_GroupGenGroups_IDD) lbSetCurSel MCC_groupGenGroupselectedIndex;		//Sets focuse on the group
			};
		};
		
	if (_type==2) then	{										//ClearWP
		if (count MCC_groupGenGroupArray > 0) then {
			MCC_groupGenGroupWP = MCC_groupGenGroupArray select (lbCurSel MCC_GroupGenGroups_IDD);
			
			hint "WP Cleared";
			[[2,[],[],[MCC_groupGenGroupWP]],'MCC_fnc_manageWp',true,false] call BIS_fnc_MP;
			sleep 1; 
			_nul=[MCC_groupGenGroupStatus] execVM MCC_path + "mcc\general_scripts\groupGen\group_manage.sqf";	//Refresh the group WP
			};
		};
	};
	
