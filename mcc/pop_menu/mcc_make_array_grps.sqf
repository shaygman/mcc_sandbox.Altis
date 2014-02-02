private ["_Cfgside","_side", "_faction", "_type","_classtype","_cfgname", "_cfgclass", "_spawnside","_grp_array","_indexar","_Cfgfaction"];
_side      = _this select 0; // Not used!
_faction   = _this select 1;
_type      = _this select 2;
_classtype = _this select 3;
_grp_array = [];
_indexar   = 0;

if (isNil "_faction") exitWith {}; 
dumtel    = 0;
dumar     = [];

#define CONFIG (configFile >> "CfgGroups" )

for "_i" from 0 to ((count CONFIG) - 1)  do
{
    _Cfgside = (CONFIG select _i);  
    if (isClass(_cfgside)) then
	{
        for "_j" from 0 to ((count _Cfgside) - 1) do
		 {
		    _Cfgfaction = (_cfgside select _j);  
			
            if (isClass(_cfgfaction)) then
			{
				for "_k" from 0 to ((count _Cfgfaction) - 1) do
				{
				_Cfgtype = (_cfgfaction select _k); 
				if (isClass(_cfgtype)) then
					{
					    _cfgname = configname(_cfgtype );
						if (_cfgname == _type) then
						{
							for "_m" from 0 to ((count _cfgtype) -1) do
							{
							   _cfgclasstype =( _cfgtype select _m);
							   if (isClass(_cfgclasstype)) then
								{
									if ((getText(_cfgclasstype >> "faction"))== _faction) then 
									{									
										_cfgname  =  getText(_cfgclasstype >> "name");
										
										_cfgclass = configname(_cfgclasstype );
										_cfgentry = format ["configFile >> ""CfgGroups"" >>""%1"">>""%2"">>""%3"">>""%4"" ",(configname (_Cfgside)),(configname (_Cfgfaction)),(configname (_Cfgtype)),(configname (_cfgclasstype))];

										if ( ["Diver", _cfgclass] call BIS_fnc_inString ) then 
										{
											_classtype = "DIVER"; // may be spawned both at land or water
										};

										//Lets count the units in a group
										private ["_count","_CfgUnit"];
										_count = 0; 
										for "_n" from 0 to ((count _cfgclasstype) - 1) do	
										{

										_CfgUnit = (_cfgclasstype select _n); 
										if (isClass(_CfgUnit)) then
											{
												_count = _count + 1;
											};
										};
									
										_grp_array set[_indexar,[_classtype,_cfgclass,_cfgentry,_cfgname,_count]];										
										_indexar = _indexar + 1;
									};
								};
							};
						};
					};
				};
			};
		 };
    };
};

_grp_array