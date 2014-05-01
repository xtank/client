package com.xtank.module
{
	import com.xtank.module.room.MapInfoView;
	import com.xtank.module.room.TankSelectView;
	import com.xtank.module.room.TeamSeatView;
	
	import onlineproto.cs_cancel_inside_ready;
	import onlineproto.cs_inside_ready;
	import onlineproto.cs_inside_start;
	import onlineproto.cs_leave_room;
	import onlineproto.player_data_t;
	import onlineproto.room_data_t;
	
	import x.game.manager.SurfaceManager;
	import x.game.module.IModuleInitData;
	import x.game.module.LifecycleType;
	import x.game.module.Module;
	import x.game.net.Connection;
	import x.game.net.post.CallbackPost;
	import x.game.net.post.SimplePost;
	import x.game.net.response.XMessageEvent;
	import x.game.ui.button.IButton;
	import x.game.ui.button.XSimpleButton;
	import x.tank.app.cfg.TankConfig;
	import x.tank.app.module.RoomModuleData;
	import x.tank.core.event.PlayerEvent;
	import x.tank.core.event.RoomEvent;
	import x.tank.core.manager.PlayerManager;
	import x.tank.core.manager.RoomManager;
	import x.tank.core.model.PlayerStatus;
	import x.tank.net.CommandSet;

	/**
	 * 房间
	 * @author fraser
	 * @time 2014-4-7
	 */
	public class RoomModule extends Module
	{
		private var _mapInfo:MapInfoView;
		private var _tankInfoView:TankSelectView;
		private var _playerTeam1Views:Vector.<TeamSeatView>;
		private var _playerTeam2Views:Vector.<TeamSeatView>;
		//
		private var _startBtn:XSimpleButton;
		private var _readyBtn:XSimpleButton;
		private var _cancelBtn:XSimpleButton;

		//

		public function RoomModule()
		{
			super();
			_lifecycleType = LifecycleType.NONCE;
		}

		override public function dispose():void
		{
			_mapInfo.dispose();
			_mapInfo = null;
			//
			_tankInfoView.dispose();
			_tankInfoView = null;
			//
			_startBtn.dispose();
			_startBtn = null;
			//
			_readyBtn.dispose();
			_readyBtn = null;
			//
			_cancelBtn.dispose();
			_cancelBtn = null;
			//
			while (_playerTeam1Views.length > 0)
			{
				_playerTeam1Views.pop().dispose();
			}
			//
			while (_playerTeam2Views.length > 0)
			{
				_playerTeam2Views.pop().dispose();
			}
			//
			super.dispose();
		}

		override public function setup():void
		{
			setMainUI(new RoomModuleUI());
			//
			_startBtn = new XSimpleButton(_mainUI["startBtn"]);
			_startBtn.addClick(onStartClick);
			//
			_readyBtn = new XSimpleButton(_mainUI["readyBtn"]);
			_readyBtn.addClick(onReadyClick);
			//
			_cancelBtn = new XSimpleButton(_mainUI["cancelBtn"]);
			_cancelBtn.addClick(onCancelClick);
			//
			_playerTeam1Views = new Vector.<TeamSeatView>();
			_playerTeam1Views.push(new TeamSeatView(_mainUI["p1"], 1, 1));
			_playerTeam1Views.push(new TeamSeatView(_mainUI["p2"], 1, 2));
			_playerTeam1Views.push(new TeamSeatView(_mainUI["p3"], 1, 3));
			//
			_playerTeam2Views = new Vector.<TeamSeatView>();
			_playerTeam2Views.push(new TeamSeatView(_mainUI["p4"], 2, 1));
			_playerTeam2Views.push(new TeamSeatView(_mainUI["p5"], 2, 2));
			_playerTeam2Views.push(new TeamSeatView(_mainUI["p6"], 2, 3));
			//
			_mapInfo = new MapInfoView(_mainUI);
			_tankInfoView = new TankSelectView(_mainUI["tankView"]);
		}

		override public function init(data:IModuleInitData):void
		{
			super.init(data);
			//
			var initData:RoomModuleData = data as RoomModuleData;
			var roomData:room_data_t = RoomManager.getRoom(initData.roomId);
			_mapInfo.data = roomData
			_tankInfoView.lock = false;
			//
			if (roomData.ownerid == TankConfig.userId) // 我是房主
			{
				_cancelBtn.visible = _cancelBtn.enable = false;
				_readyBtn.visible = _readyBtn.enable = false;
				_startBtn.visible = _startBtn.enable = true;
			}
			else
			{
				_cancelBtn.visible = _cancelBtn.enable = false;
				_readyBtn.visible = _readyBtn.enable = true;
				_startBtn.visible = _startBtn.enable = false;
			}
			//
			onRoomUpdate();
		}

		override public function show():void
		{
			super.show();
			//
			RoomManager.addEventListener(RoomEvent.ROOM_UPDATE, onRoomUpdate);
			RoomManager.addEventListener(RoomEvent.ROOM_DEL, onRoomDel);
			PlayerManager.addEventListener(PlayerEvent.PLAYER_UPDATE, onUpdatePlayer);
			Connection.addCommandListener(CommandSet.$155.id, onStartGameMessage);
		}

		override public function hide():void
		{
			super.hide();
			//
			RoomManager.removeEventListener(RoomEvent.ROOM_UPDATE, onRoomUpdate);
			RoomManager.removeEventListener(RoomEvent.ROOM_DEL, onRoomDel);
			PlayerManager.removeEventListener(PlayerEvent.PLAYER_UPDATE, onUpdatePlayer);
			Connection.removeCommandListener(CommandSet.$155.id, onStartGameMessage);
		}

		private function onUpdatePlayer(event:PlayerEvent):void
		{
			var player:player_data_t = event.player;
			var tsv:TeamSeatView = getTeamSeatViewByUser(player);
			if (tsv.seatIndex == player.seatid)
			{
				tsv.updateView() ;// 
			}
			else
			{
				var initData:RoomModuleData = _initData as RoomModuleData;
				var roomData:room_data_t = RoomManager.getRoom(initData.roomId);
				tsv.data = null;
				tsv = getTeamSeatView(player.teamid, player.seatid);
				tsv.data = {room: roomData, player: player};
			}
		}

		/** 获取对应team的座位号上的作为 */
		private function getTeamSeatView(teamId:uint, seatIndex:uint):TeamSeatView
		{
			var rs:TeamSeatView;
			var views:Vector.<TeamSeatView> = getTeamSeatViews(teamId);
			var len:uint = views.length;
			for (var i:uint = 0; i < len; i++)
			{
				if (views[i].seatIndex == seatIndex)
				{
					rs = views[i];
					break;
				}
			}
			return rs;
		}

		private function getTeamSeatViews(teamId:uint):Vector.<TeamSeatView>
		{
			if (teamId == 1)
			{
				return _playerTeam1Views;
			}
			else if (teamId == 2)
			{
				return _playerTeam2Views;
			}
			return null;
		}

		/** 获取玩家当前坐的座位  */
		private function getTeamSeatViewByUser(player:player_data_t):TeamSeatView
		{
			var views:Vector.<TeamSeatView> = getTeamSeatViews(player.teamid);
			//
			var rs:TeamSeatView;
			for each (var tsv:TeamSeatView in views)
			{
				if (tsv.data != null)
				{
					var pd:player_data_t = tsv.data["player"] as player_data_t;
					if (pd != null && pd.userid == player.userid)
					{
						rs = tsv;
						break;
					}
				}
			}
			return rs;
		}

		private function onRoomDel(event:RoomEvent = null):void
		{
			var initData:RoomModuleData = _initData as RoomModuleData;
			if (event.room.id == initData.roomId)
			{
				close();
			}
		}

		private function getPlayerBySeat(players:Vector.<player_data_t>, seatIndex:uint):player_data_t
		{
			var rs:player_data_t;
			var len:uint = players.length;
			for (var i:uint = 0; i < len; i++)
			{
				if (players[i].seatid == seatIndex)
				{
					rs = players[i];
					break;
				}
			}
			return rs;
		}

		private function onRoomUpdate(event:RoomEvent = null):void
		{
			var initData:RoomModuleData = _initData as RoomModuleData;
			var refreshTag:Boolean = false;
			if (event == null)
			{
				refreshTag = true;
			}
			else
			{
				if (event.room.id == initData.roomId)
				{
					refreshTag = true;
				}
			}

			if (refreshTag)
			{
				var roomData:room_data_t = RoomManager.getRoom(initData.roomId);
				//
				var players:Vector.<player_data_t> = getAllPlayersInTeam(1);
				var player:player_data_t;
				//
				var len:uint = _playerTeam1Views.length;
				var i:uint = 0;
				for (i = 0; i < len; i++)
				{
					player = getPlayerBySeat(players, _playerTeam1Views[i].seatIndex);
					if (player != null)
					{
						_playerTeam1Views[i].data = {room: roomData, player: player};
					}
					else
					{
						_playerTeam1Views[i].data = null;
					}
				}
				//
				players = getAllPlayersInTeam(2);
				len = _playerTeam2Views.length;
				for (i = 0; i < len; i++)
				{
					player = getPlayerBySeat(players, _playerTeam2Views[i].seatIndex);
					if (player != null)
					{
						_playerTeam1Views[i].data = {room: roomData, player: player};
					}
					else
					{
						_playerTeam1Views[i].data = null;
					}
				}
			}
		}

		private function getAllPlayersInTeam(teamId:uint):Vector.<player_data_t>
		{
			var rs:Vector.<player_data_t> = new Vector.<player_data_t>();
			//
			var initData:RoomModuleData = _initData as RoomModuleData;
			var roomData:room_data_t = RoomManager.getRoom(initData.roomId);
			for each (var dd:player_data_t in roomData.playlist)
			{
				if (dd.teamid == teamId)
				{
					rs.push(dd);
				}
			}
			return rs;
		}

		override protected function onClose(button:IButton):void
		{
			new CallbackPost(CommandSet.$153.id, new cs_leave_room(), function(event:XMessageEvent):void
			{
				close();
			}, function(event:XMessageEvent):void
			{
			}).send();
		}

		private function onStartClick(btn:IButton):void
		{
			var initData:RoomModuleData = _initData as RoomModuleData;
			var roomData:room_data_t = RoomManager.getRoom(initData.roomId);
			//
			if (TankConfig.userId == roomData.ownerid)
			{
				btn.enable = false;
				// $155
				new SimplePost(CommandSet.$155.id, new cs_inside_start()).send();
			}
			else
			{
				// 没有满足条件  [提示]
				SurfaceManager.addTextSurface("您不是房主 无法开始游戏!");
			}
		}

		private function onReadyClick(btn:IButton):void
		{
			var player:player_data_t = PlayerManager.getPlayer(TankConfig.userId);
			//
			if (player.status == PlayerStatus.INSIDE_FREE)
			{
				btn.enable = false;
				var msg:cs_inside_ready = new cs_inside_ready();
				new CallbackPost(CommandSet.$154.id, msg, function(event:XMessageEvent):void
				{
					_readyBtn.visible = _readyBtn.enable = false;
					_cancelBtn.visible = _cancelBtn.enable = true;
				}, function(event:XMessageEvent):void
				{
					btn.enable = true;
				}).send();
			}
			else
			{
				// 没有满足条件  [提示]
				SurfaceManager.addTextSurface("无法准备!");
			}
		}

		private function onCancelClick(btn:IButton):void
		{
			var player:player_data_t = PlayerManager.getPlayer(TankConfig.userId);
			//
			if (player.status == PlayerStatus.INSIDE_READY)
			{
				btn.enable = false;
				var msg:cs_cancel_inside_ready = new cs_cancel_inside_ready();
				new CallbackPost(CommandSet.$158.id, msg, function(event:XMessageEvent):void
				{
					_readyBtn.visible = _readyBtn.enable = true;
					_cancelBtn.visible = _cancelBtn.enable = false;
				}, function(event:XMessageEvent):void
				{
					btn.enable = true;
				}).send();
			}
			else
			{
				// 没有满足条件  提示
				SurfaceManager.addTextSurface("无法取消准备!");
			}
		}

		private function onStartGameMessage(event:XMessageEvent):void
		{
			// todo [open battle module]
			//
			close();
		}
	}
}
