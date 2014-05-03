package x.tank.core.cfg.model
{
	import flash.geom.Point;

	public class BarrierConfigInfo
	{
		private var _id:uint;
		private var _block:Boolean; //0 不可通过  1 可通过
		private var _type:uint; // 0 不可击穿  1 可击穿
		private var _regPoint:Point ;
		private var _hp:uint = uint.MAX_VALUE ;
		private var _cls:String ;
		private var _occpys:Vector.<Point> ;

		public function BarrierConfigInfo(xml:XML)
		{
			_id = xml.@id;
			_block = (xml.@block == 0);
			_type = xml.@type;
			//
			var reg:Array = String(xml.@reg).split(",") ;
			_regPoint = new Point(reg[0],reg[1]) ;
			if(_type == 1)
			{
				_hp = uint(xml.@hp) ;
			}
			_cls = String(xml.@cls) ;
			//
			_occpys = new Vector.<Point>() ;
		}

		public function get id():uint
		{
			return _id;
		}

		public function get block():Boolean
		{
			return _block;
		}

		public function get type():uint
		{
			return _type;
		}
		
		public function get hp():uint
		{
			return _hp ;
		}
		
		public function get reg():Point
		{
			return _regPoint ;
		}
		
		public function get cls():String
		{
			return _cls ;
		}
	}
}
