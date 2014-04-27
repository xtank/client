package x.tank.core.cfg.model
{
	import flash.geom.Point;

	public class BarrierConfigInfo
	{
		private var _id:uint;
		private var _block:Boolean; //0 不可通过  1 可通过
		private var _type:uint; // 0 不可击穿  1 可击穿
		private var _occupys:Vector.<Point> = new Vector.<Point>(); //占据的点集合

		//<barrier id="1" occupys="0,0;1,0;0,1" block="0" type="1" hp=""/>
		public function BarrierConfigInfo(xml:XML)
		{
			_id = xml.@id;
			_block = (xml.@block == 0);
			_type = xml.@type;
			//
			var ps:Array = String(xml.@occupys).split(";");
			for each (var p:String in ps)
			{
				_occupys.push(new Point(p.split(",")[0], p.split(",")[1]));
			}
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

		public function get occupys():Vector.<Point>
		{
			return _occupys;
		}
	}
}
