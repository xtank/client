package com.xtank.module.battle.netProcessor
{
	import com.xtank.module.BattleModule;
	
	import x.game.net.Connection;
	import x.game.net.processor.BaseMessageProgressor;
	import x.game.net.response.XMessageEvent;
	import x.tank.net.CommandSet;
	
	/** 处理服务器正式开始战斗通知 */
	public class BattleStartNotifyProcessor extends BaseMessageProgressor
	{
		private var _battleModule:BattleModule ;
		
		public function BattleStartNotifyProcessor(battleModule:BattleModule)
		{
			_battleModule = battleModule ;
			super();
		}
		
		override public function setup():void
		{
			Connection.addCommandListener(CommandSet.$302.id, onMessage);
		}
		
		override public function dispose():void
		{
			Connection.removeCommandListener(CommandSet.$302.id, onMessage);
		}
		
		override public function onMessage(event:XMessageEvent):void
		{
			_battleModule.onStartBattleNotify() ;
		}
	}
}