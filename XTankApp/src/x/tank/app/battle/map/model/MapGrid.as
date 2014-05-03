package x.tank.app.battle.map.model
{
	import x.tank.app.battle.map.elements.BaseMapElement;

	public class MapGrid
	{
		private var _mapx:uint ;
		private var _mapy:uint ;
		private var _passable:Boolean ;
		private var _elem:BaseMapElement ;
		//
		public function MapGrid(mapx:uint,mapy:uint,passable:Boolean = true)
		{
			_mapx = mapx ;
			_mapy = mapy ;
			_passable =  passable ;
		}
		
		public function get mapx():uint {return _mapx;}
		public function get mapy():uint {return _mapy;}
		
		public function set elem(value:BaseMapElement):void
		{
			_elem = value ;
		}
		
		public function get elem():BaseMapElement
		{
			return _elem ;
		}
		
		public function get passable():Boolean
		{
			if(_elem == null)
			{
				return _passable ;
			}
			else
			{
				return _passable && _elem.passable ;
			}
		}
	}
}