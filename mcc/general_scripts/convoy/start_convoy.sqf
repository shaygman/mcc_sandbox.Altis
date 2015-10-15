if (isnil "MCC_convoyVehicles") exitWith {systemchat "You must spawn a convoy first"};
if !mcc_isloading then
{
	if (MCC_capture_state) then
	{
		MCC_capture_var=MCC_capture_var + FORMAT ["
							[[[%1, %2 , %3, %4], %5 select 0],""MCC_fnc_startConvoy"",true,false] call BIS_fnc_MP;
							"
							,point2
							,point3
							,point4
							,point5
							,vip];
		Hint "Action captured";
	}
	else
	{
		hint "Convoy is moving";
		[[[point2,point3,point4,point5],vip select 0],"MCC_fnc_startConvoy",true,false] call BIS_fnc_MP;
	};
};
