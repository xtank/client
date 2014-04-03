package x.game.log.appender
{
    import x.game.log.core.IAppender;

	/**
	 * 通过trace输出日志类
	 * @author fraser
	 */
	public class TraceAppender implements IAppender
	{
		public function TraceAppender()
		{
		}

		public function append(level:int, msg:String):void
		{
			trace(msg);
		}
	}
}
