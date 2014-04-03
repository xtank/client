package x.tank.client.ui
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;

	/**
	 * @author fraser
	 * 创建时间：2013-7-9上午11:42:56
	 * 类说明：
	 */
	public class LoadingProgressBar
	{
		private var _skin:Sprite ;
		//
		private var _title:TextField ;
		private var _maskLayer:DisplayObject ;
		
		public function LoadingProgressBar(skin:Sprite)
		{
			_skin = skin ;
			//
			_title = _skin['txtC'] ;			
			_maskLayer = _skin['bar']['maskLayer'] ;
			_maskLayer.x = -_maskLayer.width ;
		}
		
		public function dispose():void
		{
			_skin.removeEventListener(Event.ENTER_FRAME,onEnterFrame) ;
			_skin = null ;
			_title = null ;
			_maskLayer = null ;
		}
		
		public function updateTitle(msg:String):void
		{
			_title.text = msg ;
		}
		
		public function resetBar():void
		{
			_maskLayer.x = -_maskLayer.width ;
			_speed = DEFAULT_SPEED ;
		}
		
		private static const DEFAULT_SPEED:uint = 10 ;
		//
		private var _moving:Boolean = false ;
		private var _speed:uint = 10 ;
		private var _targetX:Number ;
		
		public function progress(percent:int,print:Boolean = false):void
		{
			if(percent == 100)
			{
				_maskLayer.x = 0 ;
			}
			else
			{
				_targetX = -_maskLayer.width * (1 - percent / 100) ;			
				if(_targetX > 0)
				{
					_skin.removeEventListener(Event.ENTER_FRAME,onEnterFrame) ;
					_maskLayer.x = _targetX ;
				}
				else
				{
					if(_moving == false)
					{
						_moving = true ;
						_skin.addEventListener(Event.ENTER_FRAME,onEnterFrame) ;
					}
					else
					{
						_speed += DEFAULT_SPEED ;
					}
				}
			}	
		}
		
		private function onEnterFrame(event:Event):void
		{
			_maskLayer.x += 10 ;
			//
			if(_maskLayer.x >= 0)
			{
				_moving = false ;
				_speed = DEFAULT_SPEED ;
				_maskLayer.x = 0 ;
				_skin.removeEventListener(Event.ENTER_FRAME,onEnterFrame) ;
			}
			else if(_maskLayer.x >= _targetX)
			{
				_moving = false ;
				_speed = DEFAULT_SPEED ;
				_maskLayer.x = _targetX ;
				_skin.removeEventListener(Event.ENTER_FRAME,onEnterFrame) ;
			}
		}
	}
}