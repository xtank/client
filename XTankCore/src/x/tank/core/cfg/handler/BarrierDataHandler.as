package x.tank.core.cfg.handler
{
	import de.polygonal.ds.HashMap;
	
	import x.game.cfg.ICFGDataHandler;
	import x.tank.core.cfg.model.BarrierConfigInfo;
	
	public class BarrierDataHandler implements ICFGDataHandler
	{
		public static const FILE_NAME:String = "barriers.xml";
		
		private var _barrierDatas:HashMap;
		private var _homeDatas:HashMap ;
		
		public function BarrierDataHandler()
		{
			_barrierDatas = new HashMap() ;
			_homeDatas = new HashMap() ;
		}
		
		public function get fileName():String
		{
			return FILE_NAME;
		}
		
		public function parser(xml:XML):void
		{
			var info:BarrierConfigInfo ;
			//
			var tp:XMLList = xml.barrier;
			var len:uint = tp.length();
			for (var i:uint = 0; i < len; i++)
			{
				info = new BarrierConfigInfo(tp[i]);
				_barrierDatas.set(info.id, info);
			}
			//
			tp = xml.home;
			len = tp.length();
			for (var j:uint = 0; j < len; j++)
			{
				info = new BarrierConfigInfo(tp[j]);
				_homeDatas.set(info.id, info);
			}
		}
		
		public function getBarrier(id:uint):BarrierConfigInfo
		{
			return _barrierDatas.get(id) as BarrierConfigInfo ;
		}
		
		public function getHome(id:uint):BarrierConfigInfo
		{
			return _homeDatas.get(id) as BarrierConfigInfo ;
		}
	}
}