package x.tank.app.battle.map.elements
{
	import flash.display.DisplayObject;
	import flash.geom.Point;
	
	import x.game.ui.XComponent;
	import x.tank.app.battle.map.model.MapGrid;

	/**
	 * 基础地图元素
	 *
	 * 坦克,障碍物,各种道具
	 */
	public class BaseMapElement extends XComponent
	{
		protected var _mapx:uint;
		protected var _mapy:uint;
		protected var _passable:Boolean ; // 是否可通过

		public function BaseMapElement(skin:DisplayObject)
		{
			super(skin);
		}
		
		public function renderer():void
		{
			
		}
		
		public function moveTo($x:uint,$y:uint):void
		{
			x = $x ;
			y = $y ;
		}
		
		// 占用的格子
		public function get occpys():Vector.<Point> 
		{
			return null ;
		}
		
		public function get elementSkin():DisplayObject
		{
			return _skin ;
		}

		public function get passable():Boolean
		{
			return _passable;
		}

		public function set passable(value:Boolean):void
		{
			_passable = value;
		}

		public function get mapx():uint
		{
			return _mapx;
		}

		public function set mapx(value:uint):void
		{
			_mapx = value;
			_skin.x = _mapx * MapGrid.GRID_WIDTH;
		}

		public function get mapy():uint
		{
			return _mapy;
		}

		public function set mapy(value:uint):void
		{
			_mapy = value;
			_skin.y = _mapy * MapGrid.GRID_HEITH ;
		}
		
		//
		override public function set x(value:Number):void
		{
			super.x = value ;
			_mapx = MapGrid.converMapx(value) ;
		}
		
		//
		override public function set y(value:Number):void
		{
			super.y = value ;
			_mapy = MapGrid.converMapx(value) ;
		}
	}
}
