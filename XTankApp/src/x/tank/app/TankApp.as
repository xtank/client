package x.tank.app
{
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	
	import x.game.alert.AlertManager;
	import x.game.layer.LayerManager;
	import x.game.log.core.Logger;
	import x.game.log.profile.Stats;
	import x.game.manager.StageManager;
	import x.game.manager.TooltipManager;
	import x.game.resize.ResizeManager;
	import x.game.tick.TickerLauncher;
	import x.tank.app.cfg.TankConfig;
	import x.tank.app.processor.net.KeepLiveProcessor;
	import x.tank.app.scene.SceneManager;
	import x.tank.core.cfg.DataProxyManager;
	import x.tank.core.cfg.handler.MapDataHandler;
	import x.tank.net.locale.ErrorMap;
	import x.tank.net.locale.LabelMap;

	public class TankApp
	{
		public function initSystem(obj:Object):void
		{
			Logger.info("TankApp-system-init");
			// 初始数据
			TankConfig.initSystemConfig(obj);
			//
			Logger.isDebug = TankConfig.isDebug;
			//
			if (Logger.isDebug)
			{
				var s:Stats = new Stats();
				s.y = 300;
				StageManager.stage.addChild(s);
			}
			//	
			var resourceManager:IResourceManager = ResourceManager.getInstance();
			resourceManager.localeChain = ["zh_CN"];
			resourceManager.addResourceBundle(new ErrorMap());
			resourceManager.addResourceBundle(new LabelMap());
			//
			TickerLauncher.start();
			//
			LayerManager.initLayers() ;
			TooltipManager.init(LayerManager.topLayer.skin);
			AlertManager.setup(LayerManager.topLayer.skin);

			// System config xml files
			DataProxyManager.addHanlder(new MapDataHandler()) ;
		}

		public function initGame(obj:Object):void
		{
			Logger.info("TankApp-game-init");
			//
			TankConfig.initGameConfig(obj) ;
			// System Message Processor Init
			new KeepLiveProcessor() ;
			//
			 SceneManager.showLobby() ;
		}

		public function updatePosition(w:Number, h:Number):void
		{
			ResizeManager.updatePosition(w, h);
		}
	}
}
