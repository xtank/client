package x.tank.net.locale
{
	import mx.resources.ResourceBundle;
	
	import x.game.locale.LocaleUtil;


	/**
	 * 错误
	 * @author fraser
	 *
	 */
	public class ErrorMap extends ResourceBundle
	{

		[Embed(source = "/../locale/zh_CN/error.properties", mimeType = "application/octet-stream")]
		private static var _dataClass:Class;

		public function ErrorMap()
		{
			super("zh_CN", "error");			
			LocaleUtil.parser(new _dataClass(), this);
		}
	}
}
