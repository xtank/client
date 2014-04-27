package x.tank.app.module
{
	import x.game.module.IModuleInitData;
	
	public class RoomModuleData implements IModuleInitData
	{
		public var roomId:uint ;
		
		public function RoomModuleData(roomId:uint)
		{
			this.roomId = roomId ;
		}
	}
}