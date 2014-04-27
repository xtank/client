package x.tank.app.scene.lobby.net
{
	import onlineproto.sc_notify_player_update;
	
	import x.game.net.Connection;
	import x.game.net.processor.BaseMessageProgressor;
	import x.game.net.response.XMessageEvent;
	import x.tank.app.scene.lobby.LobbyScene;
	import x.tank.core.manager.PlayerManager;
	import x.tank.net.CommandSet;
	
	public class PlayerStatusUpdateProcessor extends BaseMessageProgressor
	{
		private var _scene:LobbyScene;
		
		public function PlayerStatusUpdateProcessor(scene:LobbyScene)
		{
			super();
			_scene = scene;
		}
		
		override public function setup():void
		{
			Connection.addCommandListener(CommandSet.$201.id, onMessage,99999);
		}
		
		override public function dispose():void
		{
			Connection.removeCommandListener(CommandSet.$201.id, onMessage);
			super.dispose();
		}
		
		override public function onMessage(event:XMessageEvent):void
		{
			var msg:sc_notify_player_update = event.msg as sc_notify_player_update;
			PlayerManager.updatePlayer(msg.player) ;
		}
	}
}