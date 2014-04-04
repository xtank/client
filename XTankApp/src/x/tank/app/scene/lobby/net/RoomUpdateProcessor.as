package x.tank.app.scene.lobby.net
{
	import onlineproto.sc_notify_room_update;
	
	import x.game.net.Connection;
	import x.game.net.processor.SystemBaseMessageProgressor;
	import x.game.net.response.XMessageEvent;
	import x.tank.app.scene.lobby.LobbyScene;
	import x.tank.core.manager.RoomManager;
	import x.tank.core.model.Room;
	import x.tank.net.CommandSet;

	/** 房间信息更新 */
	public class RoomUpdateProcessor extends SystemBaseMessageProgressor
	{
		private var _scene:LobbyScene;

		public function RoomUpdateProcessor(scene:LobbyScene)
		{
			super();
			_scene = scene;
		}

		override public function setup():void
		{
			Connection.addCommandListener(CommandSet.$156.id, onMessage);
		}

		override public function dispose():void
		{
			Connection.removeCommandListener(CommandSet.$156.id, onMessage);
			super.dispose();
		}

		override public function onMessage(event:XMessageEvent):void
		{
			var msg:sc_notify_room_update = event.msg as sc_notify_room_update;
			// 0 update 1 add 2 del
			var room:Room
			switch (msg.oper)
			{
				case 0:{
					RoomManager.updateRoom(msg.room) ;
					break;
				}
				case 1:{
					RoomManager.addRoom(msg.room) ;
					break;
				}
				case 2:{
					RoomManager.removeRoom(msg.room.id) ;
					break;
				}
			}
		}
	}
}
