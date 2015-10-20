class GAIA
{
    tag = "GAIA";
    
    class ambient
    {
        #ifdef MCCMODE
        file = "\mcc_sandbox_mod\gaia\functions\ambient";
        #else
        file = "gaia\functions\ambient";
        #endif

        class ambientCombat {};
        class ambientCombatServer {};
        class ambientCombatClient {};
        class getPlayers {};
        class isInMarker {};
        class getsideratio {};
        class SpawnGroup {};
        class ShowLocationOwner {};
        
    };
    class Cache
    {
        #ifdef MCCMODE
        file = "\mcc_sandbox_mod\gaia\functions\cache";
        #else
        file = "gaia\functions\cache";
        #endif

        class cache {};
        class cacheFar {};
        class cacheOriginalGroup {};
        class isNearPlayer {};
        class startGaiaCache {};
        class syncCachedGroup {};
        class uncache {};
        class uncacheFar {};
        class uncacheOriginalGroup {};
    };
    class General
    {
        #ifdef MCCMODE
        file = "\mcc_sandbox_mod\gaia\functions\general";
        #else
        file = "gaia\functions\general";
        #endif

        class controlGroup {};
        class findClosestPosition {};
        class getDirectionalOffsetPosition {};
        class getMarkerShape {};
        class getMarkerVertices {};
        class isInCircle {};
        class isInEllipse {};
        class isInRectangle {};
        class isPositionInMarker {};
        class isSamePosition {};
        class randomPositionInCircleMarker {};
        class randomPositionInEllipseMarker {};
        class randomPositionInRectangleMarker {};
        class randomPositionInSquareMarker {};
        class rotatePosition {};
        class startGaia {};
    };
    class Control
    {
        #ifdef MCCMODE
        file = "\mcc_sandbox_mod\gaia\functions\control";
        #else
        file = "gaia\functions\control";
        #endif

        class addAttackWaypoint {};
        class addWaypoint {};
        class analyzeForces {};
        class analyzeTargets {};
        class analyzeTerrain {};
        class calculateOptimalPosition {};
        class classifySide {};
        class doTask {};
        class event {};
        class fireFlare {};
        class generateBuildingPatrolWaypoints {};
        class generateWaypoints {};
        class getConflictAreaCost {};
        class getConflictAreas {};
        class getDistanceToClosestZone {};
        class getTurretWeapons {};
        class getUnitAssets {};
        class getUnitTypeAmounts {};
        class getUnitsClassification {};
        class getZoneIntendOfGroup {};
        class getZoneStatusBehavior {};
        class hasLineOfSight {};
        class isBlacklisted {};
        class isCleared {};
        class issueOrders {};
        class occupy {};
        class removeWaypoints {};
        
    };
    class Orders
    {
        #ifdef MCCMODE
        file = "\mcc_sandbox_mod\gaia\functions\control\orders";
        #else
        file = "gaia\functions\control\orders";
        #endif

        class doArtillery {};
        class doAttack {};
        class doAttackCar {};
        class doAttackHelicopter {};
        class doAttackInfantry {};
        class doAttackMechanizedInfantry {};
        class doAttackMotorizeInfantry {};
        class doAttackMotorizedRecon {};
        class doAttackRecon {};
        class doAttackShip {};
        class doAttackTank {};
        class doClear {};
        class doClearInfantry {};
        class doClearRecon {};
        class doFortify {};
        class doHide {};
        class doMortar {};
        class doOrganizeTransportation {};
        class doPark {};
        class doPatrol {};
        class doPatrolCar {};
        class doPatrolHelicopter {};
        class doPatrolInfantry {};
        class doPatrolMechanizedInfantry {};
        class doPatrolMotorizedInfantry {};
        class doPatrolMotorizedRecon {};
        class doPatrolRecon {};
        class doPatrolShip {};
        class doSupport {};
        class doTransportCar {};
        class doTransportHelicopter {};
        class doTransportTank {};
        class doWait {};
    };
    class Fortify
    {
        #ifdef MCCMODE
        file = "\mcc_sandbox_mod\gaia\functions\control\fortify";
        #else
        file = "gaia\functions\control\fortify";
        #endif

        class taskDefend {};
    };
};
