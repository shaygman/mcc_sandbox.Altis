enableSaving [false, false];

waituntil {!isnil "paramsArray"};
switch (paramsArray select 2) do
{
	case 0:
	{
		setDate [2016,8,1,07,0];
	};
	case 1:
	{
		setDate [2016,8,1,12,0];
	};
	case 2:
	{
		setDate [2016,8,1,18,0];
	};
	case 3:
	{
		setDate [2016,8,1,0,0];
	};
};