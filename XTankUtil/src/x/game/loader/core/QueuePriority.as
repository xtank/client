package x.game.loader.core
{
	/**
	 * 优先级 
	 * @author tb
	 * 
	 */	
	public class QueuePriority
	{
		/**
		 * 强制加载优先级，不等待任何加载项，立即启动加载，如果有正在加载的将被关闭
		 */
		public static const COERCE:int = 0; //coerce
		/**
		 * 高优先级，排在标准前面
		 */
		public static const HIGH:int = 1;
		/**
		 * 标准优先级
		 */
		public static const STANDARD:int = 2;
		/**
		 * 低优先级
		 */
		public static const LOW:int = 3;
	}
}