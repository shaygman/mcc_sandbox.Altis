mcc_delayed_spawn		= false;
mcc_caching				= false;
mcc_delayed_spawns		= [];
mcc_safe_pos			= [];
mcc_spawntype   		= "";
mcc_classtype   		= "";
mcc_isnewzone   		= false;
mcc_spawnwithcrew 		= true;
mcc_spawnname     		= "";
mcc_spawnfaction  		= "";
mcc_spawndisplayname    = "";
mcc_zoneinform    		= "NOTHING";
mcc_zone_number			= 1;
mcc_zone_markername 	= '1';
mcc_zone_markposition   = [];
mcc_markerposition      = [];
mcc_zone_marker_X   	= 200;
mcc_zone_marker_Y		= 200;
mcc_spawnbehavior       = "MOVE";
mcc_awareness			= "DEFAULT";
mcc_zone_pos  		= 	[];
mcc_zone_size 		= 	[];
mcc_zone_dir 		= 	[];
mcc_zone_types		= 	[];
mcc_zone_locations	= 	[];
mcc_grouptype			= "";
mcc_track_units			= false;
mcc_safe				= "";
mcc_load				= "";
mcc_isloading			= false;
mcc_resetmissionmaker	= false;
if (isnil "mcc_missionmaker") then {mcc_missionmaker = ""};
mcc_firstTime			= true; //First time runing?
mcc_pickitem 			= false;

MCC_path="";
//----------------------gaia------------------------------------------------------
call compile preprocessfile format ["%1gaia\gaia_init.sqf",MCC_path];


//-----------------------Bon artillery --------------------------------------------
