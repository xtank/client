package com.xtank.module
{
	import com.xtank.module.battle.netProcessor.BattleReadyProcessor;
	import com.xtank.module.battle.netProcessor.BattleStartNotifyProcessor;
	import com.xtank.module.battle.netProcessor.MoveNotifyProcessor;
	
	import flash.geom.Point;
	
	import onlineproto.battle_data_t;
	import onlineproto.battle_team_data_t;
	import onlineproto.cs_battle_ready;
	import onlineproto.sc_tank_move;
	import onlineproto.sc_tank_move_stop;
	
	import x.game.module.IModuleInitData;
	import x.game.module.LifecycleType;
	import x.game.module.Module;
	import x.game.net.post.SimplePost;
	import x.game.net.processor.IMessageProcessor;
	import x.tank.app.battle.controller.KeyController;
	import x.tank.app.battle.map.BattleMap;
	import x.tank.app.battle.map.elements.Home;
	import x.tank.app.battle.map.tank.Tank;
	import x.tank.app.cfg.TankConfig;
	import x.tank.app.module.BattleModuleData;
	import x.tank.core.cfg.model.MapDataTeamInfo;
	import x.tank.net.CommandSet;
	
	/** 
	 *  战斗模块
	 */
	public class BattleModule extends Module
	{
		private var _map:BattleMap ;
		private var _battleData:battle_data_t ;
		protected var _msgHandlerVec:Vector.<IMessageProcessor>;
		
		public function BattleModule()
		{
			super();
			_lifecycleType = LifecycleType.NONCE;
		}
		
		override public function dispose():void
		{
			_map.dispose() ;
			_map = null ;
			//
			for each (var handler:IMessageProcessor in _msgHandlerVec)
			{
				handler.dispose();
				handler = null;
			}
			_msgHandlerVec = null;
			//
			super.dispose() ;
		}
		
		override public function setup():void
		{
			setMainUI(new BattleModuleUI());
		}
		
		override public function init(data:IModuleInitData):void
		{
			super.init(data);
			//
			_battleData = (data as BattleModuleData).data ;
			// init net handlers
			_msgHandlerVec = new Vector.<IMessageProcessor>();
			// 1. sc_battle_ready
			_msgHandlerVec.push(new BattleReadyProcessor()) ;
			// 2. sc_notify_battle_start 
			_msgHandlerVec.push(new BattleStartNotifyProcessor(this)) ;
			// 3. sc_tank_move  && sc_tank_move_stop
			_msgHandlerVec.push(new MoveNotifyProcessor(this)) ;
			
			// load battle assets
			loadBattleAssets() ;
		}
		
		override public function show():void
		{
			super.show() ;
			trace("show battle module");
		}
		
		override public function hide():void
		{
			super.hide();
			trace("hide battle module");
		}
		
		private function loadBattleAssets():void
		{
			// when load complete , show map and then notify server
			_map = new BattleMap(_battleData.mapid) ;
			addChild(_map.mapSkin) ;
			//
			createTeam(_battleData.team1) ;
			createTeam(_battleData.team2) ;
			//
			new SimplePost(CommandSet.$301.id,new cs_battle_ready()).send() ;
		}
		
		private function createTeam(teamData:battle_team_data_t):void
		{
			var teamInfo:MapDataTeamInfo = _map.mapConfigInfo.getTeamInfo(teamData.teamid) ; 
			//
			var tank:Tank ;
			_map.elemLayer.addHome(new Home(teamData,teamInfo)) ;
			//
			var len:uint = teamData.memberList.length ;
			for(var i:uint =0;i<len;i++)
			{
				
				// _map.mapConfigInfo.teams[i].members
				tank = new Tank(teamData.memberList[i]) ;
				tank.mapx = teamInfo.members[i].born.x ;
				tank.mapy = teamInfo.members[i].born.y ;
				//
				_map.elemLayer.addTank(tank) ;
				if(teamData.memberList[i].userid == TankConfig.userId)
				{
					KeyController.tank = tank ;
				}
			}
		}
		
		public function onStartBattleNotify():void
		{
			trace("正式开始战斗....") ;
			KeyController.active() ;
		}
		
		public function onTankMove(message:sc_tank_move):void
		{
			var tank:Tank = _map.elemLayer.getTankByUserId(message.userid) ;
			tank.walk(message.dir,new Point(message.startX,message.startY)) ;
		}
		
		public function onTankMoveStop(message:sc_tank_move_stop):void
		{
			var tank:Tank = _map.elemLayer.getTankByUserId(message.userid) ;
			tank.wait(tank.direction,new Point(message.stopX,message.stopY)) ;
		}
	}
}