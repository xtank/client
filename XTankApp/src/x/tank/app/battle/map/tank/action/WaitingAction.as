package x.tank.app.battle.map.tank.action
{
	import flash.display.MovieClip;
	
	import x.game.manager.UIManager;
	import x.game.ui.XComponent;
	import x.game.util.DisplayObjectUtil;
	import x.tank.app.battle.map.tank.Tank;
	
	// 待机动作
	public class WaitingAction extends XComponent implements ITankAction
	{
		private var _tank:Tank ;
		
		public function WaitingAction(tank:Tank)
		{
			_tank = tank ;
			super(UIManager.getMovieClip("Tank_UI_" + tank.memberData.tankid + "_Wait"));
			skin.gotoAndStop(1) ;
		}
		
		public function get skin():MovieClip
		{
			return _skin as MovieClip ;
		}
		
		public function get tank():Tank
		{
			return _tank ;
		}
		
		private var _currentFrame:uint = 1 ;
		
		public function playAction():void
		{
			_currentFrame = 1;
			skin.gotoAndStop(1) ;
		}
		
		public function stopAction():void 
		{
			DisplayObjectUtil.removeFromParent(skin) ;
			//
			_currentFrame = 1;
			skin.gotoAndStop(1) ;
		}
		
		public function updateAction():void
		{
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
	}
}