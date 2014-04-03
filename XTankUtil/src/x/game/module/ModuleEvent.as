package x.game.module
{
	import flash.events.Event;

	/**
	 * 模块事件
	 * @author fraser
	 *
	 */
	public class ModuleEvent extends Event
	{
		/** 模块初始化安装UI */
		public static const SET_UP:String = "setup";
		/** 模块初始化数据 */
		public static const INIT:String = "init";
		/** 模块初始化显示 */
		public static const SHOW:String = "show";
		/** 模块初始化隐藏 */
		public static const HIDE:String = "hide";
		/** 模块初始化销毁 */
		public static const DISPOSE:String = "dispose";

		/** 模块名称 */
		private var _name:String;
		private var _content:*;

		public function ModuleEvent(name:String, type:String, content:* = null, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
			_name = name;
			_content = content;
		}

		public function get name():String
		{
			return _name;
		}

		public function get content():*
		{
			return _content;
		}
	}
}
