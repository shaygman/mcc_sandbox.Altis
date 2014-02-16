Garrison script by zorilya

	This script will allow you to make a more lively urban environment where you have to check every window and door in every house
rather than having in the back of your mind 'it's arma, AI don't go in buildings very well'. the units you put into buildings
will remain there pretty well under fire but if you get bogged down they might come to you so bust in a clear them out.

	you can also use this to liven up a patrol route by setting the waypoint onAct with the script so the group gets there and garrisons a nearby building.
then to get them to leave run the "fnc_next_waypooint.sqf" the onAct of a scripted waypoint. set the condition to whatever you'd like and they will then 
leave when the condition is met and regroup at the scripted waypoint position.


to run just use this template;
		
		nul = [unit,radius,stationary (bool),capacityarray ([(0 - 100),max in one building] default [60,0]),warping (bool),allUseCQC_AI (including non garrisoned units) (bool)] execVM "Garrison_script.sqf";

		where unit is the leader of the group and radius is the radius of the area he will search for buildings.
		so like this

		nul = [_leader,100,true,[60,3],false,true] execVM "Garrison_script.sqf"		



	then your dudes will wait a sec and pick a building from the area at random and fill it up then pick another
and fill it and so on until there are no more buildings or no more units.

if all buildings are occupied or none are in range, the group randomly patrol around staying in the general area of the nearest building
 
or

if no buildings at all the group will break up into 4 man squads and patrol around the original position


Please remember this makes a random choice from the buildings in an area... if you want them in a specific building just set the radius really small 
and move the leader really close to the building. works a treat :)


you may Improve on this design so long as there is atleast a mention of the source and obviously that you share so we can all benifit.

works with vanilla AI as it has it's own CQC_AI improvments. the CQC_AI can be applyied to units without the need for the Garrison script too and really sharpens up a unit's reactions.

to run that just use
	
	nul = [_unit] execVM "CQC_AI.sqf";

this will add more realistiic vision reaction, proximity reactions and weapon noise reactions. for further details on how they work, check out my videos describing them  at "http://www.youtube.com/zorilya" or have a read of the scripts. 
enjoy

suggested for fun !

		add about 6 enemy groups into a building heavy area and run the garrison on all of the leaders setting the radius to about 50m.

		try and kill them all it's quick to set up and a ton of fun.

Stress test:
		I have run this on 24 groups (with 10 or more units each. 240 units give or take) and had a further 40 units without it on my PC, not a dedicated server and saw a minimal drop in performance. 
		320 runing this killed it for me though, FPS was noticably down. I have no doubt this is just because i was hosting and playing on the same machine. as of 1.5 this may have changed.

known issues : 
		AI will still occasionally be retarded. on the whole though things are better :)

ChangeLog v1.7.1

ADDED : extra parameter to control if CQC_AI is applied to all units or just Garrisoned Units (see template);
FIXED : Stupid doStop removed that was making units unable to complete waypoints if using CQC_AI;

ChangeLog v1.7

ADDED : TOO MANY THINGS TO COUNT. many different functions to improve moving, reacting, and patroling.
ADDED : whole new CQC_AI;
ADDED : ability for the use of waypoints to Garrison and unGarrison buildings (using above mentioned method);
FIXED : 3 major while loops that would under certain circumstances loop indefinately.
IMPROVED : performance through numerous reworks of functions. 

Missed 1.6 :s

Changelog v1.5.1
hotfix

Fixed : sorted roaming problem caused by unstable variable. roaming now works as intended.
changed : Tweaked the willwalk.sqf to improve roaming.

Changelog v1.5

Added : cqc reaction funtions. Units are now more aware of enemies when they fire round close by and look in a logical direction.
Added : garrisoned units can now move inside buildings, improving randomness of the environment.

Changed : 4 man limit to patrol groups then next group is made and so on.
Changed : many other little optimisations.

Changelog v1.4 

Added : indoors check to control behaviour i.e. crouching on roofs and balconys (works better than the old top third check);
Added : check for watch towers (and other buiildings) to avoid 3 units garrisoning the one tower (who makes a one man watch tower with 3 positions? who does that?)
Added : vision obscured check to stop units looking in useless directions.

Changed : increased time that script waits for a patrol group before exiting to 4 minutes to handle yet more pathfinding issues.


changelog v1.3

added : small tweak so that units look around a little more, it's random!
added : height check relative to building so that units now crouch when on roofs. balconys and overhangs that are not the top of a building are a liitle hit and miss.
added : persitance to getting into position. pathfinding being as problematic as it can be, a unit will try a few times to get into position before givin up and joining a patrol group.

changed : no longer required the World_build_list.sqf or any other over arching variables. This means you can nowuse in on any map!
Changed : optimised the script since the first change making it on average 3 seconds faster when executing (less standing around looking gormless).
Changed : Improved the checks for occuppied buildings to ensure even less doubling up when garrisoning with multiple groups in the same area (seems to only mess up when i accellerate time hehe).
changed : better system for patrol script to loop (doesn't constantly call the script anymore);

Removed : all world buildings lists. no need for them any more.
Removed : annoying debug hints that are no longer needed thanks to patrol script.

changelog v1.2

added : redesigned building check to include an occupied variable so as to avoid different groups garrisoning the same building.
added : patrol script. if all buildings are occupied or none are in range, the group randomly partol around staying in the general area of the nearest building.

changelog v1.1

added : compatibility with more islands
added : randomiser for stationary command
 