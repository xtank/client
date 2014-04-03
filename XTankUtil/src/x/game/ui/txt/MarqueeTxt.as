package x.game.ui.txt
{
    import flash.events.Event;
    import flash.text.TextField;
    import flash.text.TextFieldAutoSize;
    
    import x.game.core.IDisposeable;

    public class MarqueeTxt implements IDisposeable
    {
        private var _txt:TextField;

        //房间滚动次数
        private var _rollCount:uint;
        //控制字符串滚动的速度
        private var _rollSpeed:uint;
		//判断房间的滚动次数
		private var _count:uint = 0;

        public function MarqueeTxt(txt:TextField)
        {
            _txt = txt;
        }
		
		public function dispose():void
		{
			closeRoll() ;
			_txt = null ;
		}

        public function setScrollText(rolltext:String,rollCount:uint = 100, rollSpeed:uint = 2):void
        {
			//
			_count = 0 ;
			_rollCount = rollCount;
			_rollSpeed = rollSpeed;
            //外部加载进来的文本附值给动态文本框my_txt
			_txt.x = 600 ;
			_txt.htmlText = rolltext;
			_txt.autoSize = TextFieldAutoSize.RIGHT;
			_txt.multiline = false ;
			_txt.selectable = false;
            //滤镜
			_txt.addEventListener(Event.ENTER_FRAME, yd);
        }

        //设置次数		
        private function yd(e:Event):void
        {
            //淡出
            if (_count < _rollCount)
            {
                roll();
            }
            else
            {
                closeRoll();
            }
        }

        //滚动方法
        private function roll():void
        {
			_txt.x -= _rollSpeed;
            //循环滚动判断
            if (_txt.x < -_txt.width)
            {
				_txt.x = 600;
				_count += 1;
            }
        }

        public function closeRoll():void
        {
			_count = 0 ;
			_txt.removeEventListener(Event.ENTER_FRAME, yd);
			_txt.htmlText = "" ;
        }
    }
}
