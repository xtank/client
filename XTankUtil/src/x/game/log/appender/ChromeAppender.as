package x.game.log.appender
{
	import flash.external.ExternalInterface;
	
	import x.game.log.core.IAppender;
	import x.game.log.core.LogLevel;

	/**
	 * 通过chrome游览器输出日志类
	 * @author fraser
	 */
	public class ChromeAppender implements IAppender
	{
		private var _consoleMethods:Array;

		public function ChromeAppender()
		{
			_consoleMethods = new Array();
			_consoleMethods[LogLevel.ALL] = "console.log";
			_consoleMethods[LogLevel.DEBUG] = "console.debug";
			_consoleMethods[LogLevel.INFO] = "console.info";
			_consoleMethods[LogLevel.WARN] = "console.warn";
			_consoleMethods[LogLevel.ERROR] = "console.error";
			_consoleMethods[LogLevel.FATAL] = "console.error";
		}

		public function append(level:int, msg:String):void
		{
			if (ExternalInterface.available)
			{
				ExternalInterface.call(_consoleMethods[level], msg);
			}
            else
            {
                trace(msg);
            }
		}
	}
}
