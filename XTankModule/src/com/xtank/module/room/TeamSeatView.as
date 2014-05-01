package com.xtank.module.room
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import onlineproto.cs_select_team;
	import onlineproto.player_data_t;
	import onlineproto.room_data_t;
	
	import x.game.net.post.SimplePost;
	import x.game.ui.XComponent;
	import x.game.util.DisplayObjectUtil;
	import x.tank.net.CommandSet;
	
	public class TeamSeatView extends XComponent
	{
		public var teamId:uint ;
		public var seatIndex:uint ;
		//
		private var _playerName:TextField ;
		private var _ownerTag:MovieClip ;
		private var _statusTag:MovieClip ;
		private var _tank:MovieClip ;
		
		public function TeamSeatView(skin:DisplayObject,teamId:uint,seatIndex:uint)
		{
			super(skin);
			//
			this.teamId = teamId ;
			this.seatIndex = seatIndex ;
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
			//
			skinPlayerView.addEventListener(MouseEvent.CLICK,onChangeTeamPosition) ;
		}
		
		override public function dispose():void
		{
			skinPlayerView.removeEventListener(MouseEvent.CLICK,onChangeTeamPosition) ;
			super.dispose(); 
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
		
		public function updateView():void
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
				_tank.gotoAndStop(player.tankid) ;
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
		
		private function onChangeTeamPosition(event:MouseEvent):void
		{
			if (data == null)
			{
				var msg:cs_select_team = new cs_select_team() ;
				msg.teamid = teamId ;
				msg.seatid = seatIndex ;
				new SimplePost(CommandSet.$159.id, msg).send();
			}
		}
	}
}