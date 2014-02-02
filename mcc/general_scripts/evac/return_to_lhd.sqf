#define FLY_HIGHT 6101

private ["_point1", "_flyInHight"];

if !mcc_isloading then 
	{
	if (mcc_missionmaker == (name player)) then
	{	
	deletemarkerlocal "evac_marker1";
	deletemarkerlocal "evac_marker2";
	deletemarkerlocal "evac_marker3";
	
	_flyInHight =  MCC_evacFlyInHight_array select (lbCurSel FLY_HIGHT) select 1;
	MCC_evacFlyInHight_index = lbCurSel FLY_HIGHT;
	
	_point1 = getmarkerpos "pos4";
	hint "Returning to LHD";
	if (MCC_capture_state) then
		{
		MCC_capture_var = MCC_capture_var + FORMAT ['
							[[%1, %2, 2],"MCC_fnc_evacMove",true,false] spawn BIS_fnc_MP;
							'
							,[_point1]
							,_flyInHight
							];
		} else
			{
			[[[_point1], _flyInHight, 2],"MCC_fnc_evacMove",true,false] spawn BIS_fnc_MP;
			};
	}	
		else { player globalchat "Access Denied"};
	};
