package x.game.locale
{
	import mx.resources.ResourceBundle;
	
	
	/**
	 * 错误 
	 * @author fraser
	 * 
	 */
	public class LocalDemo extends ResourceBundle
	{
		[Embed(source = "label.properties", mimeType = "application/octet-stream")]
		private static var _dataClass:Class;
		
		public function LocalDemo()
		{
			super("zh_CN", "LocalDemo"); 
			// #
			initContent() ;
		}
		
		private function initContent():void 
		{
			var data:String = new _dataClass() ; 
			LocaleUtil.parser(data,this) ;
		}
	}
}