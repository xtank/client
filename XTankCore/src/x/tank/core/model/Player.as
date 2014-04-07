package x.tank.core.model
{
	import onlineproto.player_data_t;
	
	/**
	 * 玩家模型
	 * @author fraser
	 */
	public class Player
	{
		public var id:uint ;
		public var name:String ;
		/** @see PlayerStatus */
		public var status:uint ;
		
		public function Player()
		{
		}
		
		public function parse(data:player_data_t):void
		{
			this.id = data.userid ;
			this.status = data.status ;
		}
	}
}