package x.tank.app.battle.map.tank.action
{
	import flash.display.MovieClip;
	
	import x.tank.app.battle.map.tank.Tank;

	public interface ITankAction
	{
		function get actionName():String ;
		function get tank():Tank ;
		function get skin():MovieClip;
		function playAction():void ;
		function stopAction():void ;
		function updateAction():void ;
		function endAction():void ;
	}
}