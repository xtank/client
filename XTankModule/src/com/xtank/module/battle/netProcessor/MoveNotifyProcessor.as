package com.xtank.module.battle.netProcessor
{
	import com.xtank.module.BattleModule;
	
	import onlineproto.sc_tank_move;
	import onlineproto.sc_tank_move_stop;
	
	import x.game.net.Connection;
	import x.game.net.processor.BaseMessageProgressor;
	import x.game.net.response.XMessageEvent;
	import x.tank.net.CommandSet;
	
	/** tank移动通知 */
	public class MoveNotifyProcessor extends BaseMessageProgressor
	{
		private var _battleModule:BattleModule ;
		
		public function MoveNotifyProcessor(battleModule:BattleModule)
		{
			_battleModule = battleModule ;
			super();
		}
		
		override public function setup():void
		{
			Connection.addCommandListener(CommandSet.$304.id, onMoveMessage);
			Connection.addCommandListener(CommandSet.$305.id, onStopMessage);
		}
		
		override public function dispose():void
		{
			Connection.removeCommandListener(CommandSet.$304.id, onMoveMessage);
			Connection.removeCommandListener(CommandSet.$305.id, onStopMessage);
		}
		
		public function onMoveMessage(event:XMessageEvent):void
		{
			_battleModule.onTankMove(event.msg as sc_tank_move) ;
		}
		
		public function onStopMessage(event:XMessageEvent):void
		{
			_battleModule.onTankMoveStop(event.msg as sc_tank_move_stop) ;
		}
	}
}