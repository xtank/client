package x.tank.core.model
{
	import de.polygonal.ds.HashMap;
	
	import onlineproto.player_data_t;
	import onlineproto.room_data_t;
	
	import x.tank.core.manager.PlayerManager;
	
	/**
	 * 房间模型
	 * @author fraser
	 */
	public class Room
	{
		public var id:uint;
		public var ownerid:uint;
		public var mapid:uint;
		/** @see RoomStatus */
		public var status:uint; //0 free 1 busy
		public var playlist:HashMap ;
		public var passwd:uint;
		public var name:String = " - ";

		public function Room()
		{
			playlist = new HashMap() ;
		}
		
		public function get owner():Player
		{
			return playlist.get(ownerid) as Player;
		}
		
		// 当前参与房间的玩家数量
		public function get currentCount():uint
		{
			return playlist.size() ;
		}

		public function parse(data:room_data_t):void
		{
			this.id = data.id;
			this.ownerid = data.ownerid;
			this.status = data.status;
			this.mapid = data.mapid;
			this.passwd = data.passwd;
			this.name = data.name ;
			//
			playlist.clear() ;
			//
			var player:Player ;
			for each(var playData:player_data_t in data.playlist)
			{
				if(PlayerManager.hasPlayer(playData.usierid) )
				{
					PlayerManager.updatePlayer(playData) ;
				}
				else
				{
					player = PlayerManager.addPlayer(playData) ;
				}
				playlist.set(player.id,player) ;
			}
		}
	}
}
