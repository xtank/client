package x.tank.app.module
{
	import onlineproto.room_data_t;
	
	import x.game.module.IModuleInitData;
	
	public class RoomModuleData implements IModuleInitData
	{
		public var roomdata:room_data_t ;
		
		public function RoomModuleData(roomdata:room_data_t)
		{
			this.roomdata = roomdata ;
		}
	}
}