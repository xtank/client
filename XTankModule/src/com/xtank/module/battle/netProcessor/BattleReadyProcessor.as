package com.xtank.module.battle.netProcessor
{
	import x.game.net.Connection;
	import x.game.net.processor.BaseMessageProgressor;
	import x.game.net.response.XMessageEvent;
	import x.tank.net.CommandSet;
	
	public class BattleReadyProcessor extends BaseMessageProgressor
	{
		public function BattleReadyProcessor()
		{
			super();
		}
		override public function setup():void
		{
			Connection.addCommandListener(CommandSet.$301.id, onMessage);
		}
		
		override public function dispose():void
		{
			Connection.removeCommandListener(CommandSet.$301.id, onMessage);
		}
		
		override public function onMessage(event:XMessageEvent):void
		{
			// do nothing
		}
	}
}