package x.tank.app.module
{
	import onlineproto.battle_data_t;
	
	import x.game.module.IModuleInitData;
	
	public class BattleModuleData implements IModuleInitData
	{
		public var data:battle_data_t ;
		
		public function BattleModuleData($data:battle_data_t)
		{
			data = $data ;
		}
	}
}