package x.tank.core.model
{
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
		public var playlist:Vector.<Player>;
		public var passwd:uint;

		public function Room()
		{
			playlist = new Vector.<Player>();
		}

		public function parse(data:room_data_t):void
		{
			this.id = data.usierid;
			this.ownerid = data.ownerid;
			this.status = data.status;
			this.mapid = data.mapid;
			this.passwd = data.passwd;
			//
			playlist.splice(0, playlist.length - 1);
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
				playlist.push(player) ;
			}
		}
	}
}
