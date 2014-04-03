package x.game.model
{
	import flash.events.Event;
	import flash.events.EventDispatcher;

	/**
	 * 全局声音音量
	 * @author lynx
	 * @create Jan 31, 2013 5:17:46 PM
	 */
	public class SoundVolume extends EventDispatcher
	{
		/** 全局音效音量 **/
		public static const ExplodVolume:SoundVolume = new SoundVolume();
		/** 全局背景音乐音量 **/
		public static const BMGVolume:SoundVolume = new SoundVolume();

		private var _value:Number = 1;
		private var _enable:Boolean = true;

		public function get value():Number
		{
			return _value;
		}

		public function set value(v:Number):void
		{
			if (_value != v)
			{
				_value = v;
				dispatchEvent(new Event(Event.CHANGE));
			}
		}

		public function get enable():Boolean
		{
			return _enable && _value != 0;
		}

		public function set enable(value:Boolean):void
		{
			if (_enable != value)
			{
				_enable = value;
				dispatchEvent(new Event(Event.CHANGE));
			}
		}
	}
}
