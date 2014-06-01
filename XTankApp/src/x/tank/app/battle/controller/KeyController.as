package x.tank.app.battle.controller
{
	import x.tank.app.battle.map.tank.Tank;

	public class KeyController
	{
		private static var _tank:Tank ;
		
		public static function set tank(value:Tank):void
		{
			_tank = value ;
		}
		
		public static function active():void
		{
			
		}
		
		public static function deActive():void
		{
			
		}
	}
}