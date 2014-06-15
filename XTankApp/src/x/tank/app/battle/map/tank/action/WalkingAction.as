package x.tank.app.battle.map.tank.action
{
	import flash.display.MovieClip;
	import flash.utils.getTimer;
	
	import x.game.manager.UIManager;
	import x.game.ui.XComponent;
	import x.game.util.DisplayObjectUtil;
	import x.tank.app.battle.map.tank.Tank;
	import x.tank.app.battle.map.tank.TankActionEnum;
	import x.tank.app.battle.utils.Direction;
	
	public class WalkingAction extends XComponent implements ITankAction
	{
		private var _tank:Tank ;
		
		public function WalkingAction(tank:Tank)
		{
			_tank = tank ;
			//
			super(UIManager.getMovieClip("Tank_UI_" + tank.memberData.tankid + "_Walk"));
			skin.gotoAndStop(1) ;
		}
		
		public function get actionName():String 
		{
			return TankActionEnum.WALKING ;
		}
		
		public function get skin():MovieClip
		{
			return _skin as MovieClip ;
		}
		
		public function get tank():Tank
		{
			return _tank;
		}
		
		private var _currentFrame:uint = 1 ;
		
		public function playAction():void
		{
			_currentFrame = 1;
			skin.gotoAndStop(1) ;
		}
		
		public function stopAction():void
		{
			_updateTimeTag = 0 ;
			DisplayObjectUtil.removeFromParent(skin) ;
			//
			_currentFrame = 1;
			skin.gotoAndStop(1) ;
		}
		
		private var _updateTimeTag:uint ;
		private var _remainTime:uint ;
		
		public function updateAction():void
		{
			if(_updateTimeTag == 0)
			{
				_updateTimeTag = getTimer() ;
			}
			else
			{
				var deltraTime:Number = getTimer() - _updateTimeTag ; //时间差
				_updateTimeTag = getTimer() ;
				//
				var speed:uint = _tank.tankConfig.speed ; // 像素每秒
				var moveDistance:Number = speed * deltraTime/1000 ;
				move(moveDistance) ;
			}
			//
			if(_currentFrame < skin.totalFrames)
			{
				_currentFrame++ ;
				skin.gotoAndStop(_currentFrame) ;
			}
			else
			{
				endAction() ;
			}
		}
		
		public function endAction():void
		{
			_currentFrame = 1;
			skin.gotoAndStop(1) ;
		}
		
		private function move(distance:Number):void
		{
			// trace("moveDistance:" + distance);
			//
			if(_tank.direction == Direction.DOWN)
			{
				_tank.y+=distance ;
			}
			else if(_tank.direction == Direction.UP)
			{
				_tank.y-=distance ;
			}
			else if(_tank.direction == Direction.LEFT)
			{
				_tank.x -=distance ;
			}
			else if(_tank.direction == Direction.RIGHT)
			{
				_tank.x +=distance ;
			}
		}
	}
}