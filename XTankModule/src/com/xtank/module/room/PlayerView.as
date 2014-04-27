package com.xtank.module.room
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.text.TextField;
	
	import onlineproto.player_data_t;
	import onlineproto.room_data_t;
	
	import x.game.ui.XComponent;
	import x.game.util.DisplayObjectUtil;
	
	public class PlayerView extends XComponent
	{
		private var _playerName:TextField ;
		private var _ownerTag:MovieClip ;
		private var _statusTag:MovieClip ;
		private var _tank:MovieClip ;
		
		public function PlayerView(skin:DisplayObject)
		{
			super(skin);
			_playerName = skin["playerName"] ;
			DisplayObjectUtil.disableTarget(_playerName) ;
			//
			_ownerTag = skin["ownerTag"] ;
			DisplayObjectUtil.disableTarget(_ownerTag) ;
			//
			_statusTag = skin["statusTag"] ;
			DisplayObjectUtil.disableTarget(_statusTag) ;
			//
			_tank = skin["tank"];
			_tank.gotoAndStop(1) ;
			DisplayObjectUtil.disableTarget(_tank) ;
		}
		
		public function get skinPlayerView():Sprite
		{
			return _skin as Sprite ;
		}
		
		override public function set data(value:Object):void
		{
			super.data = value;
			updateView();
		}
		
		private function updateView():void
		{
			if (data != null)
			{
				var room:room_data_t = data.room as room_data_t ;
				var player:player_data_t = data.player as player_data_t ;
				//
				_playerName.text = player.name+"[" + player.userid+ "]" ; ;
				_ownerTag.visible = (room.ownerid == player.userid);
				_statusTag.gotoAndStop(player.status) ;
				//
				_tank.gotoAndStop(1) ;
				_tank.visible = true ;
			}
			else
			{
				_tank.visible = false ;
				_playerName.text = "" ;
				_ownerTag.visible = false ;
				_statusTag.gotoAndStop(1) ;
				_statusTag.visible = false ;
				_tank.gotoAndStop(1) ;
				_tank.visible = false ;
			}
		}
	}
}