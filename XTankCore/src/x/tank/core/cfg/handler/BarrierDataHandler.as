package x.tank.core.cfg.handler
{
	import de.polygonal.ds.HashMap;
	
	import x.game.cfg.ICFGDataHandler;
	import x.tank.core.cfg.model.BarrierConfigInfo;
	
	public class BarrierDataHandler implements ICFGDataHandler
	{
		public static const FILE_NAME:String = "barriers.xml";
		
		private var _datas:HashMap;
		
		public function BarrierDataHandler()
		{
			_datas = new HashMap() ;
		}
		
		public function get fileName():String
		{
			return FILE_NAME;
		}
		
		public function parser(xml:XML):void
		{
			var tp:XMLList = xml.barrier;
			var len:uint = tp.length();
			for (var i:uint = 0; i < len; i++)
			{
				var info:BarrierConfigInfo = new BarrierConfigInfo(tp[i]);
				_datas.set(info.id, info);
			}
		}
		
		public function getBarrier(id:uint):BarrierConfigInfo
		{
			return _datas.get(id) as BarrierConfigInfo ;
		}
	}
}