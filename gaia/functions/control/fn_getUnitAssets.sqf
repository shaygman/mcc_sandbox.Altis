//==================================================================fnc_countUnit===============================================================================================
// Count the assets of a unit (at, aa etc) based on ammo (better then guns as guns dont kill)
// Flaw: the ammo carrier that does not have the gun will still be counted as the type of ammo it carries
// Example: [unit/vehicle] call fnc_countUnit;
// By Spirit 8-1-2014
//===========================================================================================================================================================================	
private ["_unit","_MagazinesUnit","_ammo"];

_unit 			= _this select 0; 

_MagazinesUnit=[];
_MagazinesUnit=(magazines _unit ); 


_at =false;//Is Anti tank
_aal=false;//Is Anti Air Light (Bullet based)
_aah=false;//Is Anti Air Heavy (rocket/launcher based) -> airlock
_art=false;//Is Artillery
_found_AT_stuff = false;
//_MagazinesUnit set [count _MagazinesUnit,(currentMagazine _unit)];
	
	{
		_irlock = 0;_laserlock=0;_airlock=0;_artilleryLock=0;
		_ammo 					= tolower gettext (configFile >> "CfgMagazines" >> _x >> "ammo");		
		_irlock					= getNumber (configfile >> "CfgAmmo" >> _ammo >> "irLock");
		_laserlock			= getNumber (configfile >> "CfgAmmo" >> _ammo >> "laserLock");
		_airlock				= getNumber (configfile >> "CfgAmmo" >> _ammo >> "airLock");		
		_airlock				= getNumber (configfile >> "CfgAmmo" >> _ammo >> "airLock");				
		_artilleryLock	= getNumber (configfile >> "CfgAmmo" >> _ammo >> "artilleryLock");		
		
		if (_airlock==1 and (_ammo iskindof "BulletBase")) then
			{_aal=true;};
		if (_airlock==2 and !(_ammo iskindof "BulletBase")) then
			{_aah=true;};			
	  if (
	  		(_irlock>0 or _laserlock>0)
	  	 	and
	  	 	_airlock==0 
	  	 	and 
	  	 	(	(_ammo iskindof "RocketBase") 
	  	 		or 
	  	 		(_ammo iskindof "MissileBase") 
	  	 	)
	  	 or
	  	 (_ammo iskindof "ShellBase" and _artilleryLock==0 )
	  	 )  	 
	  	 
	  then
			{_at=true;};	
			
		if (_artilleryLock==1 and !(_ammo iskindof "BulletBase")) then
			{_art=true;};	
			
//Fail safe. If non of the above is true, we possible form still some AT stuff. Most likely non guide AT. So set him up.
	if (
				(_ammo iskindof "RocketBase") 
		  	 		or 
		  	(_ammo iskindof "MissileBase") 	
			) then
			{_found_AT_stuff = true;};			
	} foreach _MagazinesUnit; 

//Ok this is absolutely crap. It needs more attention but for now it is the best show. If only the config was filled correctly by all.... Needs dynamic.
if ((!_at and !_aah and !_art)
		and
		_found_AT_stuff
	 )
then
{
	_at = true;	
};

[_at,_aal,_aah,_art]
