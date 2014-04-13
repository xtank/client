package x.tank.core.ui
{
	import flash.display.DisplayObjectContainer;
	
	import x.game.layer.LayerManager;
	import x.game.loader.loadingUI.ILoaderUI;
	import x.game.manager.StageManager;

	/**
	 * 加载进度条
	 * @author fraser
	 *
	 */
	public class GameLoadingBar implements ILoaderUI
	{
		private static var _instance:GameLoadingBar;

		public static function get instance():GameLoadingBar
		{
			if (_instance == null)
			{
				_instance = new GameLoadingBar();
			}
			return _instance;
		}


		private var _loadingBar:LoadingBar;

		public function show(title:String = "", isCover:Boolean = true, parent:DisplayObjectContainer = null):void
		{
			if (_loadingBar == null)
			{
				_loadingBar = new LoadingBar();
			}
			//
			if (parent == null)
			{
				parent = LayerManager.topLayer.skin;
			}
			//
			_loadingBar.show(parent, isCover, StageManager.fixWidth, StageManager.fixHeight);
			_loadingBar.title = title;
		}

		public function updateTitle(title:String):void
		{
			_loadingBar.title = title;
		}

		/** 子进度 */
		public function progressTotal(percent:uint):void
		{
			if (_loadingBar != null)
			{
				_loadingBar.progress(percent);
			}
		}

		public function hide():void
		{
			if (_loadingBar != null)
			{
				_loadingBar.hide();
			}
		}

//		static private var _index:uint = 0;
//		static private var _count:uint = 0;
//		
//		static public function stopAutoLoadingBarProgress():void
//		{
//			if (_index != 0)
//			{
//				clearInterval(_index);
//				_index = 0;
//				_count = 0;
//			}
//		}
//		
//		static public function startAutoLoadingBarProgress():void
//		{
//			stopAutoLoadingBarProgress() ;
//			//
//			_index = setInterval(autoLoadingBarProgress, 100);
//		}
//		
//		static public function autoLoadingBarProgress():void
//		{
//			if (_count <= 99)
//			{
//				GameLoadingBar.progressTotal(_count);
//				_count++;
//			}
//			else
//			{
//				stopAutoLoadingBarProgress();
//			}
//		}
	}
}
