package com.xtank.module
{
	import com.xtank.module.battle.netProcessor.BattleReadyProcessor;
	import com.xtank.module.battle.netProcessor.BattleStartNotifyProcessor;
	
	import onlineproto.battle_data_t;
	import onlineproto.cs_battle_ready;
	
	import x.game.module.IModuleInitData;
	import x.game.module.LifecycleType;
	import x.game.module.Module;
	import x.game.net.post.SimplePost;
	import x.game.net.processor.IMessageProcessor;
	import x.tank.app.battle.map.BattleMap;
	import x.tank.app.module.BattleModuleData;
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
			//
			// init net handlers
			_msgHandlerVec = new Vector.<IMessageProcessor>();
			// 1. sc_battle_ready
			_msgHandlerVec.push(new BattleReadyProcessor()) ;
			// 2. sc_notify_battle_start 
			_msgHandlerVec.push(new BattleStartNotifyProcessor(this)) ;
			
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
			new SimplePost(CommandSet.$301.id,new cs_battle_ready()).send() ;
		}
		
		public function onStartBattleNotify():void
		{
			trace("正式开始战斗....") ;
		}
	}
}