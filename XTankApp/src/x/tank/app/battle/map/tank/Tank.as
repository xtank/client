package x.tank.app.battle.map.tank
{
	import flash.display.Sprite;
	
	import de.polygonal.ds.HashMap;
	
	import onlineproto.battle_member_data_t;
	
	import x.tank.app.battle.map.elements.BaseMapElement;
	import x.tank.app.battle.map.tank.action.ITankAction;
	import x.tank.app.battle.map.tank.action.WaitingAction;
	import x.tank.app.battle.map.tank.action.WalkingAction;
	import x.tank.core.cfg.DataProxyManager;
	import x.tank.core.cfg.model.TankConfigInfo;
	
	
	/** 坦克 */
	public class Tank extends BaseMapElement
	{
		private var _currentAction:ITankAction ;
		private var _actions:HashMap ;
		private var _memberData:battle_member_data_t ;
		//
		private var _direction:uint ; // 0 up 1 down 2 left 3 right
		private var _hp:uint ; // 血量
		private var _speed:uint ; // 移动速度
		private var _defense:uint ; // 防御力
		private var _attack:uint ; // 攻击力
		private var _attackSpeed:uint ; // 攻击速度
		private var _attackScope:uint ; // 攻击射程
		
		public function Tank(memberData:battle_member_data_t)
		{
			super(new Sprite());
			_memberData = memberData ;
			_passable = false ;
			_actions = new HashMap() ;
			playAction(TankActionEnum.WAITING) ;
			//
			var tankConfig:TankConfigInfo = DataProxyManager.tankData.getTankInfo(memberData.tankid) ;
			//
			_direction = _memberData.dir ;
			_hp = tankConfig.hp ;
			_speed = tankConfig.speed ;
			_defense = tankConfig.defense ;
			_attack = tankConfig.attack ;
			_attackSpeed = tankConfig.attackSpeed ;
			_attackScope = tankConfig.attackScope ;
			//
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