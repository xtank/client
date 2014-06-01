package
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	
	import x.game.manager.UIManager;
	import x.tank.core.cfg.DataProxyManager;
	import x.tank.core.cfg.model.BarrierConfigInfo;

	public class BarrierInfo
	{
		public var id:uint;
		public var reg:Point = new Point(0, 0);
		public var type:uint = 0; // 0 不可击穿  1 可击穿
		public var hp:uint = 0;
		public var cls:String;
		public var occpys:Vector.<Point> ;
		public var res:BitmapData ;
		public var startTag:String ;
		//
		private var _configInfo:BarrierConfigInfo ;

		public function BarrierInfo(id:uint,clsPrefix:String,startTag:String)
		{
			this.id = id;
			this.startTag = startTag ;
			cls = clsPrefix + id ;
			res = UIManager.getBitmapData(cls) ;
			//
			if(startTag == "barrier")
			{
				_configInfo = DataProxyManager.barrierData.getBarrier(id) ;
			}
			else 
			{
				_configInfo = DataProxyManager.barrierData.getHome(id) ;
			}
					
			if(_configInfo != null)
			{
				reg = _configInfo.reg ;
				type = _configInfo.type ;
				hp = _configInfo.hp ;
				occpys = _configInfo.occpys ;
			}
			else
			{
				reg = new Point(-res.width/2,-res.height/2) ;
				type = 0 ;
				hp = 0 ;
				occpys = new Vector.<Point>() ;
			}
		}

		public function description():String
		{
			return '<' + startTag + ' id="' + id + '" reg="' + reg.x + ',' + reg.y + '" type="' + type + '" hp="' + hp + '" cls="' + cls + '" occpy="' + occpyDes + '"/>'
		}
		
		public function addOccpy(mapx:int,mapy:int):void
		{
			var del:Boolean = false ;
			var len:uint = occpys.length ;
			for(var i:uint = 0;i<len;i++)
			{
				if(occpys[i].x == mapx && occpys[i].y == mapy)
				{
					occpys.splice(i,1) ;del=true ;break;
				}
			}
			if(!del)
			{
				occpys.push(new Point(mapx,mapy)) ;
			}
		}

		public function get occpyDes():String
		{
			var rs:Array = [] ;
			for each(var p:Point in occpys)
			{
				if(!isNaN(p.x) && !isNaN(p.y))
				{
					rs.push(p.x+","+p.y);
				}
			}
			return rs.join(";") ;
		}
	}
}
