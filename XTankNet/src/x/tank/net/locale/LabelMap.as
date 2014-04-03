package x.tank.net.locale
{
	import mx.resources.ResourceBundle;
	
	import x.game.locale.LocaleUtil;
	
	/**
	 * 
	 * @author fraser
	 * 
	 */
	public class LabelMap extends ResourceBundle
	{
		
		[Embed(source = "/../locale/zh_CN/label.properties", mimeType = "application/octet-stream")]
		private static var _dataClass:Class;
		
		public function LabelMap()
		{
			super("zh_CN", "label");
			//###
			LocaleUtil.parser(new _dataClass(),this) ;
		}
	}
}