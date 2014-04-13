package x.game.ui.digital
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	
	import x.game.ui.XComponent;
	import x.game.util.DisplayObjectUtil;
	import x.game.util.MathUtil;
	
	public class DigitalNumber extends XComponent
	{
		private var _digitals:Vector.<MovieClip> ;
		
		public function DigitalNumber(skin:DisplayObject,digitals:Vector.<MovieClip>)
		{
			super(skin);
			//
			_digitals = digitals ;
			for each (var dot:MovieClip in _digitals)
			{
				DisplayObjectUtil.disableTarget(dot);
			}
			updateValue(0);
		}
		
		public function updateValue(value:int):void
		{
			value = value < 0 ? 0 : value;
			var valueNotZero:Boolean = false ;
			//
			var len:uint = _digitals.length;
			var ns:Vector.<int> = MathUtil.parseNumberToLimitLengthDigitVec(value,len);
			for (var i:uint = 0; i < len; i++)
			{
				if(ns[i] > 0 || i == (len-1))
				{
					valueNotZero = true ;
				}
				_digitals[i].gotoAndStop(ns[i] + 1);
				//
				if(valueNotZero == false && ns[i] == 0)
				{
					_digitals[i].visible = false ;
				}
				else
				{
					_digitals[i].visible = true ;
				}
			}
			var firstX:Number = _digitals[0].x ;
			for (var j:uint = 0; j < len; j++)
			{
				if(_digitals[j].visible)
				{
					_digitals[j].x = firstX ;
					//
					firstX += (_digitals[j].width + 2);
				}
			}
		}
	}
}