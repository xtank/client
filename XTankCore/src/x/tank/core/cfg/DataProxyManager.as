package x.tank.core.cfg
{
	import de.polygonal.ds.HashMap;
	
	import x.game.cfg.DataProxy;
	import x.game.cfg.ICFGDataHandler;
	import x.tank.core.cfg.handler.BarrierDataHandler;
	import x.tank.core.cfg.handler.MapDataHandler;
	import x.tank.core.cfg.handler.TankDataHandler;
	
	public class DataProxyManager
	{
		private static var _handlers:HashMap = new HashMap();

		static public function addHanlder(handler:ICFGDataHandler):void
		{
			handler.parser(DataProxy.getXmlFile(handler.fileName)) ;
			_handlers.set(handler.fileName,handler) ;
		}

		/** 地图配置文件 **/
		static public function get mapData():MapDataHandler
		{
			return _handlers.get(MapDataHandler.FILE_NAME) as MapDataHandler ;
		}
		
		static public function get tankData():TankDataHandler
		{
			return _handlers.get(TankDataHandler.FILE_NAME) as TankDataHandler ;
		}
		
		static public function get barrierData():BarrierDataHandler
		{
			return _handlers.get(BarrierDataHandler.FILE_NAME) as BarrierDataHandler ;
		}
	}
}