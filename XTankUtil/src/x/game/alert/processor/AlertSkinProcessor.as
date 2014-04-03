package x.game.alert.processor
{
	import flash.display.Sprite;
	
	import x.game.alert.impls.ImageAlert;
	import x.game.core.IDisposeable;

	/**
	 * @author fraser
	 * 创建时间：2013-3-18下午1:22:52
	 * 类说明：提示皮肤类处理类
	 */
	public class AlertSkinProcessor implements IDisposeable
	{
		protected var _alert:ImageAlert;
		/** 皮肤 */
		protected var _skin:Sprite;

		public function AlertSkinProcessor()
		{
		}

		public function initSkin(skin:Sprite):void
		{
			_skin = skin;
			processor();
		}

		protected function processor():void
		{
			// override by child
		}
		
		public function dispose():void
		{
			_skin = null;
			_alert = null ;
		}
		
		public function set alert(value:ImageAlert):void
		{
			_alert = value;
		}
		
		public function get alert():ImageAlert
		{
			return _alert;
		}

	}
}
