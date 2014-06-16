package x.tank.app.battle.map.tank
{
	import flash.display.Sprite;
	import flash.geom.Point;
	
	import de.polygonal.ds.HashMap;
	
	import onlineproto.battle_member_data_t;
	
	import x.tank.app.battle.map.BattleMap;
	import x.tank.app.battle.map.elements.BaseMapElement;
	import x.tank.app.battle.map.tank.action.ITankAction;
	import x.tank.app.battle.map.tank.action.WaitingAction;
	import x.tank.app.battle.map.tank.action.WalkingAction;
	import x.tank.app.battle.utils.Direction;
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
		//
		public var tankConfig:TankConfigInfo ;
		
		public function Tank(memberData:battle_member_data_t,$map:BattleMap)
		{
			super(new Sprite(),$map);
			_memberData = memberData ;
			_passable = false ;
			_actions = new HashMap() ;
			wait(memberData.dir,new Point(memberData.x,memberData.y)) ;// 默认为待机动画
			//
			tankConfig = DataProxyManager.tankData.getTankInfo(memberData.tankid) ;
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
			//
			//trace("tank renderer!") ;
		}
		
		public function 
		
		public function get direction():uint
		{
			return _direction ;
		}
		
		public function set direction(value:uint):void
		{
			if(_direction == value)
			{
				return ;
			}
			//
			_direction = value ;
			switch(_direction)
			{
				case Direction.UP:
				{
					tankSkin.rotation = 0 ;
					tankSkin.scaleY = 1 ;
					break;
				}
				case Direction.DOWN:
				{
					tankSkin.rotation = 0 ;
					tankSkin.scaleY = -1 ;
					break;
				}
				case Direction.LEFT:
				{
					tankSkin.rotation = -90 ;
					tankSkin.scaleY = 1 ;
					break;
				}
				case Direction.RIGHT:
				{
					tankSkin.rotation = 90 ;
					tankSkin.scaleY = 1 ;
					break;
				}
			}
		}
		
		/** @see x.tank.app.battle.utils.Direction */
		public function walk(dir:uint,startPoint:Point):void
		{
			//trace("walk",startPoint.x,startPoint.y);
			moveTo(startPoint.x,startPoint.y) ;
			//
			direction = dir ;
			playAction(TankActionEnum.WALKING) ; 
		}
		
		public function wait(dir:uint,stopPoint:Point):void
		{
			//trace("wait",stopPoint.x,stopPoint.y);
			moveTo(stopPoint.x,stopPoint.y) ;
			//
			direction = dir ;
			playAction(TankActionEnum.WAITING) ; 
		}
		
		public function playAction(actionName:String):void
		{
			if(_currentAction != null && _currentAction.actionName == actionName)
			{
				return ; //保持现有动作
			}
			
			//
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