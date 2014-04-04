package x.tank.app.scene.lobby.net
{
	import x.game.net.Connection;
	import x.game.net.processor.BaseMessageProgressor;
	import x.game.net.response.XMessageEvent;
	import x.tank.app.scene.lobby.LobbyScene;
	import x.tank.net.CommandSet;
	
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
			
		}
	}
}