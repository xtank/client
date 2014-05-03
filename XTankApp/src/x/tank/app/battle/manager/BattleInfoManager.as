package x.tank.app.battle.manager
{
	import onlineproto.battle_data_t;

	public class BattleInfoManager
	{
		private static var _instance:BattleInfoManager ;
		
		public static function get instance():BattleInfoManager
		{
			if(_instance == null)
			{
				_instance = new BattleInfoManager() ;
			}		
			return _instance ;
		}
		
		private var _data:battle_data_t ;
		//
		public function initBattleInfo(data:battle_data_t):void
		{
			_data = data ;
		}
		
		public function get battleMapId():uint
		{
			return _data.mapid ;
		}
	}
}