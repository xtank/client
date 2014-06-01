package x.tank.app.battle.map.tank
{
	import flash.display.Sprite;
	
	import de.polygonal.ds.HashMap;
	
	import onlineproto.battle_member_data_t;
	
	import x.tank.app.battle.map.elements.BaseMapElement;
	import x.tank.app.battle.map.tank.action.ITankAction;
	import x.tank.app.battle.map.tank.action.WaitingAction;
	import x.tank.app.battle.map.tank.action.WalkingAction;
	
	
	/** 坦克 */
	public class Tank extends BaseMapElement
	{
		private var _currentAction:ITankAction ;
		private var _actions:HashMap ;
		private var _memberData:battle_member_data_t ;
		
		public function Tank(memberData:battle_member_data_t)
		{
			super(new Sprite());
			_memberData = memberData ;
			_passable = false ;
			_actions = new HashMap() ;
			playAction(TankActionEnum.WAITING) ;
		}
		
		override public function renderer():void
		{
			if(_currentAction != null)
			{
				_currentAction.updateAction() ;
			}
		}
		
		public function playAction(actionName:String):void
		{
			if(_currentAction != null)
			{
				_currentAction.stopAction() ;
			}
			//
			var tmp:ITankAction = _actions.get(actionName) as ITankAction;
			if(tmp == null)
			{
				tmp = createAction(actionName) ;
			}
			_currentAction = tmp ;
			//
			tankSkin.addChild(_currentAction.skin) ;
			_currentAction.playAction() ;
		}
		
		private function createAction(actionName:String):ITankAction
		{
			var rs:ITankAction ;
			switch(actionName)
			{
				case TankActionEnum.WAITING:
				{
					rs = new WaitingAction(this) ;
					break;
				}
				case TankActionEnum.WALKING:
				{
					rs = new WalkingAction(this) ;
					break;
				}
			}
			//
			if(rs == null)
			{
				throw new Error("没有找到对应的tank动作!");
			}
			else
			{
				_actions.set(actionName,rs) ;
			}
			//
			return rs ;
		}
		
		public function get tankSkin():Sprite
		{
			return _skin as Sprite ;
		}
		
		public function get memberData():battle_member_data_t
		{
			return _memberData ;
		}
	}
}