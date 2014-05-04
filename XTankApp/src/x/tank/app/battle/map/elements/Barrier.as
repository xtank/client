package x.tank.app.battle.map.elements
{
	import flash.display.DisplayObject;
	
	import x.tank.core.cfg.model.BarrierConfigInfo;
	
	
	/** 障碍物 */
	public class Barrier extends BaseMapElement
	{
		private var _barrierConfigInfo:BarrierConfigInfo ;
		
		public function Barrier(skin:DisplayObject,barrierConfigInfo:BarrierConfigInfo)
		{
			super(skin);
			_barrierConfigInfo = barrierConfigInfo ;
		}
		
		public function get barrierSkin():DisplayObject
		{
			return _skin ;
		}
		
		override public function set mapx(value:uint):void
		{
			_mapx = value;
			x = _mapx * GRID_WIDTH + GRID_WIDTH/2 + _barrierConfigInfo.reg.x;
		}
		
		override public function set mapy(value:uint):void
		{
			_mapy = value;
			y = _mapy * GRID_HEIGHT + GRID_HEIGHT/2 + _barrierConfigInfo.reg.y;
		}
	}
}