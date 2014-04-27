package com.xtank.module
{
	import com.xtank.module.room.MapInfoView;
	import com.xtank.module.room.PlayerView;
	import com.xtank.module.room.TankSelectView;
	
	import onlineproto.cs_cancel_inside_ready;
	import onlineproto.cs_inside_ready;
	import onlineproto.cs_leave_room;
	import onlineproto.player_data_t;
	import onlineproto.room_data_t;
	import onlineproto.sc_notify_room_update;
	
	import x.game.module.IModuleInitData;
	import x.game.module.LifecycleType;
	import x.game.module.Module;
	import x.game.net.Connection;
	import x.game.net.post.CallbackPost;
	import x.game.net.response.XMessageEvent;
	import x.game.ui.button.IButton;
	import x.game.ui.button.XSimpleButton;
	import x.tank.app.cfg.TankConfig;
	import x.tank.app.module.RoomModuleData;
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
		private var _mapInfo:MapInfoView ;
		private var _selectedTankInfo:TankSelectView ;
		private var _playerTeam1Views:Vector.<PlayerView> ;
		private var _playerTeam2Views:Vector.<PlayerView> ;
		//
		private var _startBtn:XSimpleButton ;
		private var _readyBtn:XSimpleButton ;
		private var _cancelBtn:XSimpleButton ;
		
		public function RoomModule()
		{
			super();
			_lifecycleType = LifecycleType.NONCE;
		}
		
		override public function dispose():void
		{
			_mapInfo.dispose() ;
			_mapInfo = null ;
			//
			_selectedTankInfo.dispose() ;
			_selectedTankInfo = null ;
			//
			_startBtn.dispose() ;
			_startBtn = null ;
			//
			_readyBtn.dispose() ;
			_readyBtn = null ;
			//
			_cancelBtn.dispose() ;
			_cancelBtn = null ;
			//
			while(_playerTeam1Views.length > 0)
			{
				_playerTeam1Views.pop().dispose() ;
			}
			//
			while(_playerTeam2Views.length > 0)
			{
				_playerTeam2Views.pop().dispose() ;
			}
			//
			super.dispose() ;
		}
		
		override public function setup():void
		{
			setMainUI(new RoomModuleUI());
			//
			_startBtn = new XSimpleButton(_mainUI["startBtn"]) ;
			_startBtn.addClick(onStartClick) ;
			//
			_readyBtn = new XSimpleButton(_mainUI["readyBtn"]) ;
			_readyBtn.addClick(onReadyClick) ;
			//
			_cancelBtn = new XSimpleButton(_mainUI["cancelBtn"]) ;
			_cancelBtn.addClick(onCancelClick) ;
			//
			_playerTeam1Views = new Vector.<PlayerView>() ;
			_playerTeam1Views.push(new PlayerView(_mainUI["p1"])) ;
			_playerTeam1Views.push(new PlayerView(_mainUI["p2"])) ;
			_playerTeam1Views.push(new PlayerView(_mainUI["p3"])) ;
			//
			_playerTeam2Views = new Vector.<PlayerView>() ;
			_playerTeam2Views.push(new PlayerView(_mainUI["p4"])) ;
			_playerTeam2Views.push(new PlayerView(_mainUI["p5"])) ;
			_playerTeam2Views.push(new PlayerView(_mainUI["p6"])) ;
			//
			_mapInfo = new MapInfoView(_mainUI) ;
			_selectedTankInfo = new TankSelectView(_mainUI["tankView"]) ;
		}
		
		override public function init(data:IModuleInitData):void
		{
			super.init(data);
			//
			var initData:RoomModuleData = data as RoomModuleData ;
			var roomData:room_data_t = RoomManager.getRoom(initData.roomId) ;
			_mapInfo.data = roomData
			_selectedTankInfo.lock = false ;
			//
			if(roomData.ownerid == TankConfig.userId) // 我是房主
			{
				_cancelBtn.visible = _cancelBtn.enable = false ;
				_readyBtn.visible = _readyBtn.enable = false ;
				//
				_startBtn.visible = _startBtn.enable = true ;
			}
			else
			{
				_cancelBtn.visible = _cancelBtn.enable = false ;
				_readyBtn.visible = _readyBtn.enable = true ;
				_startBtn.visible = _startBtn.enable = false ;
			}
			//
			on156Message();
		}
		
		override public function show():void
		{
			super.show() ;
			//
			Connection.addCommandListener(CommandSet.$156.id, on156Message);
		}
		
		override public function hide():void
		{
			super.hide();
			//
			Connection.removeCommandListener(CommandSet.$156.id, on156Message);
		}
		
		private function on156Message(event:XMessageEvent = null):void
		{
			var initData:RoomModuleData = _initData as RoomModuleData ;
			var refreshTag:Boolean = false ;
			if(event == null)
			{
				refreshTag = true ;
			}
			else 
			{
				var msg:sc_notify_room_update = event.msg as sc_notify_room_update;
				if(msg.room.id == initData.roomId && msg.oper == 0)
				{
					refreshTag = true ;
				}
			}
				
			if(refreshTag)
			{
				var roomData:room_data_t = RoomManager.getRoom(initData.roomId) ;
				//
				var players:Vector.<player_data_t> = getAllPlayersInTeam(1) ;
				var len:uint = _playerTeam1Views.length ;
				var i:uint = 0 ;
				for(i = 0 ;i<len;i++)
				{
					if(i < players.length)
					{
						_playerTeam1Views[i].data = {room:roomData,player:players[i]} ;
					}
					else
					{
						_playerTeam1Views[i].data = null ;
					}
				}
				players = getAllPlayersInTeam(2) ;
				len = _playerTeam2Views.length ;
				for(i = 0 ;i<len;i++)
				{
					if(i < players.length)
					{
						_playerTeam2Views[i].data = {room:roomData,player:players[i]} ;
					}
					else
					{
						_playerTeam2Views[i].data = null ;
					}
				}
			}
			
		}
		
		private function getAllPlayersInTeam(teamId:uint):Vector.<player_data_t>
		{
			var rs:Vector.<player_data_t> = new Vector.<player_data_t>() ;
			//
			var initData:RoomModuleData = _initData as RoomModuleData ;
			var roomData:room_data_t = RoomManager.getRoom(initData.roomId) ;
			for each(var dd:player_data_t in roomData.playlist)
			{
				if(dd.teamid == teamId)
				{
					rs.push(dd) ;
				}
			}
			return rs ;
		}
		
		override protected function onClose(button:IButton):void
		{
			new CallbackPost(CommandSet.$153.id,new cs_leave_room(),
				function(event:XMessageEvent):void
				{
					close();
				},
				function(event:XMessageEvent):void
				{
				}
			).send() ;
		}
		
		private function onStartClick(btn:IButton):void
		{
			
		}
		
		private function onReadyClick(btn:IButton):void
		{
			var player:player_data_t = PlayerManager.getPlayer(TankConfig.userId) ;
			//
			if(player.status == PlayerStatus.INSIDE_FREE)
			{
				btn.enable = false ;
				var msg:cs_inside_ready = new cs_inside_ready() ;
				new CallbackPost(CommandSet.$154.id,msg,
					function(event:XMessageEvent):void
					{
						_readyBtn.visible =  _readyBtn.enable = false ;
						_cancelBtn.visible = _cancelBtn.enable = true ;
					},
					function(event:XMessageEvent):void
					{
						btn.enable = true ;
					}
				).send() ;
			}
			else
			{
				// 没有满足条件  提示
			}
		}
		
		private function onCancelClick(btn:IButton):void
		{
			var player:player_data_t = PlayerManager.getPlayer(TankConfig.userId) ;
			//
			if(player.status == PlayerStatus.INSIDE_READY)
			{
				btn.enable = false ;
				var msg:cs_cancel_inside_ready = new cs_cancel_inside_ready() ;
				new CallbackPost(CommandSet.$158.id,msg,
					function(event:XMessageEvent):void
					{
						_readyBtn.visible =  _readyBtn.enable = true ;
						_cancelBtn.visible = _cancelBtn.enable = false ;
					},
					function(event:XMessageEvent):void
					{
						btn.enable = true ;
					}
				).send() ;
			}
			else
			{
				// 没有满足条件  提示
			}
		}
	}
}