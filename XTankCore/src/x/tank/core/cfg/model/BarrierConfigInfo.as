package x.tank.core.cfg.model
{
	import flash.geom.Point;

	public class BarrierConfigInfo
	{
		private var _id:uint;
		private var _type:uint; // 0 不可击穿  1 可击穿
		private var _regPoint:Point ;
		private var _hp:uint = uint.MAX_VALUE ;
		private var _cls:String ;
		private var _occpys:Vector.<Point> ;

		public function BarrierConfigInfo(xml:XML)
		{
			_id = xml.@id;
			_type = xml.@type;
			//
			var reg:Array = String(xml.@reg).split(",") ;
			_regPoint = new Point(reg[0],reg[1]) ;
			if(_type == 1)
			{
				_hp = uint(xml.@hp) ;
			}
			_cls = String(xml.@cls) ;
			// <barrier id="6" reg="-61.5,-118.5" type="0" hp="0" cls="Barrier_6" occpy="-1,0;0,0;1,0;-1,-1;0,-1;1,-1"/>
			// -1,0;0,0;1,0;1,1;0,1;-1,1
			_occpys = new Vector.<Point>() ;
			var datas:Array = String(xml.@occpy).split(";") ;
			for each(var d:String in datas)
			{
				_occpys.push(new Point(d.split(",")[0],d.split(",")[1])) ;
			}
		}
		
		public function get occpys():Vector.<Point>
		{
			return _occpys ;
		}

		public function get id():uint
		{
			return _id;
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
