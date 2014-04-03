package x.game.alert.impls
{
	import flash.display.Sprite;
	import flash.system.ApplicationDomain;
	
	import x.game.enum.PostFix;
	import x.game.loader.core.ContentInfo;
	import x.game.loader.core.LoadType;
	import x.game.loader.core.QueueLoader;
	import x.game.manager.StageManager;
	import x.game.manager.VersionManager;
	import x.game.util.DisplayUtil;



	/**
	 * 图形类  Alert
	 *
	 * @author barlow
	 * @modify fraser
	 * 创建时间：2013-1-28下午6:03:38
	 */
	public class ImageAlert extends AlertBase
	{
		//
		public static const ALERT_RES_URL:String = "assets/alert/" ;
		
		/** ImageAlert 图片 */
		public static function getImageAlertURL(imageID:uint):String
		{
			return VersionManager.getURL(ALERT_RES_URL + imageID + PostFix.SWF);
		}
		
		/**被加载进来的资源的域*/
		private var _alertDomain:ApplicationDomain;
		
		public function ImageAlert(imageID:uint, showCover:Boolean = true)
		{
			super();
			this.showCover = showCover;
			//
			QueueLoader.load(getImageAlertURL(imageID), LoadType.SWF, onLoadImageSucc);
		}

		override public function dispose():void
		{
			_alertDomain = null;
			super.dispose();
		}

		protected function onLoadImageSucc(conInfo:ContentInfo):void
		{
			var content:Sprite = conInfo.content;
			_alertDomain = conInfo.domain;
			addChild(content);
			//
			if (_processor != null)
			{
				_processor.initSkin(content);
				_processor.alert = this;
			}
			// 居中显示提示框
			DisplayUtil.align(this, StageManager.stageRect);
		}
		
		public function get alertDomain():ApplicationDomain
		{
			return _alertDomain;
		}

	}
}
