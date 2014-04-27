package x.tank.core.cfg.handler
{
	import de.polygonal.ds.HashMap;
	
	import x.game.cfg.ICFGDataHandler;
	import x.tank.core.cfg.model.TankConfigInfo;
	
	public class TankDataHandler implements ICFGDataHandler
	{
		public static const FILE_NAME:String = "tank.xml";
		
		private var _datas:HashMap;
		
		public function TankDataHandler()
		{
			_datas = new HashMap() ;
		}
		
		public function get fileName():String
		{
			return FILE_NAME;
		}
		
		public function parser(xml:XML):void
		{
			var tp:XMLList = xml.tank;
			var len:uint = tp.length();
			for (var i:uint = 0; i < len; i++)
			{
				var info:TankConfigInfo = new TankConfigInfo(tp[i]);
				_datas.set(info.id, info);
			}
		}
		
		public function getTankInfo(mapId:uint):TankConfigInfo
		{
			return _datas.get(mapId) as TankConfigInfo ;
		}
	}
}