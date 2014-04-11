package x.tank.app.scene.lobby.view
{
	import flash.display.DisplayObject;
	
	import x.game.ui.XComponent;
	
	public class RoomListView extends XComponent
	{
		private var _roomView:Vector.<LobbyRoomView> ;
		
		public function RoomListView(skin:DisplayObject)
		{
			super(skin);
			_roomView = new Vector.<LobbyRoomView>() ;
		}
	}
}