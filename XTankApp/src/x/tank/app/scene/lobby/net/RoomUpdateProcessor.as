package x.tank.app.scene.lobby.net
{
	import onlineproto.sc_notify_room_update;
	
	import x.game.net.processor.SystemBaseMessageProgressor;
	import x.game.net.response.XMessageEvent;
	import x.tank.app.scene.lobby.LobbyScene;
	
	public class RoomUpdateProcessor extends SystemBaseMessageProgressor
	{
		private var _scene:LobbyScene ;
		
		public function RoomUpdateProcessor(scene:LobbyScene)
		{
			super();
			_scene = scene ;
		}
		
		override public function setup():void
		{
//			Connection.addCommandListener(CommandSet.$102.id,onMessage) ;
		}
		
		override public function dispose():void
		{
//			Connection.removeCommandListener(CommandSet.$102.id,onMessage) ;
			super.dispose() ;
		}
		
		override public function onMessage(event:XMessageEvent):void
		{
			var msg:sc_notify_room_update = event.msg as sc_notify_room_update ; 
			msg.oper // 0 update 1 add 2 del
		}
	}
}