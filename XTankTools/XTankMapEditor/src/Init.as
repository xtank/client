package
{
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.Stage;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import x.game.manager.UIManager;
	import x.game.tick.TickerLauncher;
	import x.tank.app.battle.map.BattleMap;
	import x.tank.core.cfg.DataProxyManager;
	import x.tank.core.cfg.handler.BarrierDataHandler;
	import editordata.MapData;

	public class Init
	{
		private var _uiLoader:Loader;
		private var _urlLoader:URLLoader;
		private var _map:BattleMap ;
		private var _stage:Stage ;
		private var _onComplete:Function;
		
		public function Init(stage:Stage,onComplete:Function)
		{
			_stage = stage ;
			_onComplete = onComplete ;
			_urlLoader = new URLLoader(); 
			_urlLoader.addEventListener(Event.COMPLETE,loadMAPComplete) ;
			_urlLoader.load(new URLRequest("../../proto/cfg/map.xml"));
		}
		
		private function loadMAPComplete(event:Event):void
		{
			_urlLoader.removeEventListener(Event.COMPLETE,loadMAPComplete) ;
			_stage.scaleMode = StageScaleMode.NO_SCALE ;
			TickerLauncher.start() ;
			//
			var xx:XML = XML(_urlLoader.data) ;
			var xxx:XMLList = xx.map ;
			for each(var a:XML in xxx)
			{
				DataManager.addMapData(new MapData().parser(a)) ;
			}
			//
			_urlLoader.addEventListener(Event.COMPLETE,loadBARComplete) ;
			_urlLoader.load(new URLRequest("../../proto/cfg/barriers.xml"));
		}
		
		private function loadBARComplete(event:Event):void
		{
			_urlLoader.removeEventListener(Event.COMPLETE,loadBARComplete) ;
			//
			var handler:BarrierDataHandler = new BarrierDataHandler();
			handler.parser(XML(_urlLoader.data)) ;
			DataProxyManager.addHandler2(handler);
			//
			loadUI();
		}
		
		private function loadUI():void
		{
			
			_uiLoader = new Loader();
			_uiLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onUIComplete);
			//
			var req:URLRequest = new URLRequest("../../client/XTankPublish/dlls/XTankUI.swf");
			_uiLoader.load(req);
		}
		
		private function onUIComplete(event:Event):void
		{
			var loaderInfo:LoaderInfo = event.target as LoaderInfo;
			loaderInfo.removeEventListener(Event.COMPLETE, onUIComplete);
			UIManager.setup(_uiLoader.contentLoaderInfo.applicationDomain);
			//
			if(_onComplete != null) 
			{
				_onComplete() ;
			}
					
		}
	}
}