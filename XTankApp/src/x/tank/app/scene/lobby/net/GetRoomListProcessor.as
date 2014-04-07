package x.tank.app.scene.lobby.net
{
	import onlineproto.room_data_t;
	import onlineproto.sc_get_room_list;
	
	import x.game.net.Connection;
	import x.game.net.processor.BaseMessageProgressor;
	import x.game.net.response.XMessageEvent;
	import x.tank.app.scene.lobby.LobbyScene;
	import x.tank.core.event.RoomEvent;
	import x.tank.core.manager.RoomManager;
	import x.tank.net.CommandSet;

	/** 获取房间列表  **/
	public class GetRoomListProcessor extends BaseMessageProgressor
	{
		private var _scene:LobbyScene;

		public function GetRoomListProcessor(scene:LobbyScene)
		{
			super();
			_scene = scene;
		}

		override public function setup():void
		{
			Connection.addCommandListener(CommandSet.$151.id, onMessage);
		}

		override public function dispose():void
		{
			Connection.removeCommandListener(CommandSet.$151.id, onMessage);
			super.dispose();
		}

		override public function onMessage(event:XMessageEvent):void
		{
			var msg:sc_get_room_list = event.msg as sc_get_room_list;
			var len:uint = msg.roomList.length;
			var data:room_data_t ;
			for (var i:uint = 0; i < len; i++)
			{
				data = msg.roomList[i] ;
				if(RoomManager.hasRoom(data.id))
				{
					RoomManager.updateRoom(data) ;
				}
				else
				{
					RoomManager.addRoom(data) ;
				}
			}
			//
			RoomManager.dispatchEvent(new RoomEvent(RoomEvent.ROOM_LIST_UPDATE));
		}
	}
}
