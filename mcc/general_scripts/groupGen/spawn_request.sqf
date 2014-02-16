//Made by Shay_Gman (c) 09.10
#define groupGen_IDD 2994

#define UNIT_TYPE 3010
#define UNIT_CLASS 3011
#define MCC_GGUNIT_TYPE 3012
#define MCC_GGUNIT_EMPTY 3016

private ["_type","_mccdialog","_comboBox","_displayname","_index","_wpType","_wpComabt","_wpFormation","_wpSpeed","_wpBehavior","_nul",
		 "_wpText","_wpTextStatement","_wpTimOut","_spawnType","_classtype","_timeout"];
disableSerialization;

_type = _this select 0;

_mccdialog = findDisplay groupGen_IDD;
MCC_groupBroadcast = []; 
MCC_isEmpty = if (ctrlShown (_mccdialog displayCtrl MCC_GGUNIT_EMPTY) && (lbCurSel MCC_GGUNIT_EMPTY == 1) && (count MCC_groupGenCurrenGroupArray == 0)) then {true} else {false};  
if !mcc_isloading then	
{
	//Spawn Group
	if (_type==0) then	
	{	
		//Case we are spawning a cfg Group
		if ((lbCurSel MCC_GGUNIT_TYPE) == 1) then
		{
			if (((MCC_groupTypes select (lbCurSel UNIT_TYPE) select 0)) =="Custom")
			then
			{
				_comboBox = _mccdialog displayCtrl UNIT_CLASS;	
				_classtype = MCC_customGroupsSave select (call compile (_comboBox lbData (lbCurSel UNIT_CLASS)));
				MCC_groupBroadcast  = (_classtype select 2); 
			}
			else
			{
				_classtype	= (MCC_groupArray select (lbCurSel UNIT_CLASS)) select 2;
				MCC_groupBroadcast = _classtype;
			};
		}
		else		//Case we are spawning a unit 
		{
			//Case we are spawning a unit with out a group. 
			if (count MCC_groupGenCurrenGroupArray == 0) then
			{
				_groupArray = []; 
				switch (lbCurSel UNIT_TYPE) do		//Which unit do we want
				{
				   case 0:	//Infantry
					{
						_groupArray = U_GEN_SOLDIER;
					};
					
					case 1:	//Car
					{
						_groupArray = U_GEN_CAR;
					};
					
					case 2:	//Tank
					{
						_groupArray = U_GEN_TANK;
					};
					
					case 3:	//Motorcycle
					{
						_groupArray = U_GEN_MOTORCYCLE;
					};
					
					case 4:	//Helicopter
					{
						_groupArray = U_GEN_HELICOPTER;
					};
					
					case 5:	//Aircraft
					{
						_groupArray = U_GEN_AIRPLANE;
					};
					
					case 6:	//Ship
					{
						_groupArray = U_GEN_SHIP;
					};
				};
				
				_classtype	= (_groupArray select (lbCurSel UNIT_CLASS)) select 1;
				MCC_groupBroadcast = [_classtype];
			}
			else
			{
				MCC_groupBroadcast = MCC_groupGenCurrenGroupArray;
			};
		};
		
		click = false; 
		_timeout = time + 5; 
		hint "click on the map"; 
		onMapSingleClick " 	hint ""Group Spawned."";
						click = true; 
						mcc_safe = mcc_safe + FORMAT ['
									[[%1 , %2, %3, %4, %5],""MCC_fnc_groupSpawn"",false,false] spawn BIS_fnc_MP;
									sleep 1;'
									, _pos
									, MCC_groupBroadcast
									, mcc_hc
									, mcc_sidename
									, MCC_isEmpty
									];
						[[_pos, MCC_groupBroadcast, mcc_hc, mcc_sidename, MCC_isEmpty],'MCC_fnc_groupSpawn',false,false] spawn BIS_fnc_MP;
						onMapSingleClick """";";
		waituntil {click || (time > _timeout)}; 
		sleep 1; 
		[west,east,resistance,civilian] execVM format ["%1mcc\general_scripts\groupGen\group_manage.sqf",MCC_path];	//Refresh the group WP
	};
};
