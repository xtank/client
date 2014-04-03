package x.game.ui.scroller
{
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import x.game.ui.XComponent;
	import x.game.ui.button.IButton;
	import x.game.ui.button.XButton;
	import x.game.ui.button.XSimpleButton;
	
	public class Scroller extends XComponent
	{
        /** 滑块按钮  */
        protected var _sliderBtn:IButton;
        /** 滑块范围 */
        protected var _thumbRange:Number;
        /**  */
        protected var _onScroll:Function;
        /**  */
        protected var _initData:ScrollerInitData;
        /**  */
        protected var _scrollPercent:Number = 0;
        //
        protected var _curSpeed:Number;
        
		public function Scroller(mainUI:MovieClip, onScroll:Function, initData:ScrollerInitData)
		{
            super(mainUI);
            _initData = initData;
            _onScroll = onScroll;
            //
            initComponents() ;
		}
        
        public function get skin():Sprite
        {
            return _skin as Sprite;
        }
        
        protected function initComponents():void
        {
            if (_skin[_initData.sliderBtnName] != null)
            {
                if(_skin[_initData.sliderBtnName] is SimpleButton)
                {
                    _sliderBtn = new XSimpleButton(_skin[_initData.sliderBtnName]);
                }
                else
                {
                    _sliderBtn = new XButton(_skin[_initData.sliderBtnName]);
                }
                
                _sliderBtn.addDownClick(thumb_onMouseDown);
            }
            //
            if (_initData.isMouseWheel)
            {
                _initData.stage.addEventListener(MouseEvent.MOUSE_WHEEL, stage_onMouseWheel);
            }
        }
		
		override public function dispose():void
		{
            _initData = null ;
			_onScroll = null;
            //
            if (_sliderBtn != null)
            {
                _sliderBtn.dispose();
                _sliderBtn = null;
            }
            //
            _initData.stage.removeEventListener(MouseEvent.MOUSE_MOVE, stage_onMouseMove);
            _initData.stage.removeEventListener(MouseEvent.MOUSE_UP, stage_onMouseUp);
            _initData.stage.removeEventListener(MouseEvent.MOUSE_WHEEL, stage_onMouseWheel);
            //
			super.dispose();
		}
        
        public function set scrollPercent(value:Number):void
        {
            value = value > 1 ? 1:value ;
            value = value < 0 ? 0:value ;
            //
            if(value == _scrollPercent)
                return ;
            //
            _scrollPercent = value;
            //
            if (_onScroll != null)
            {
                _onScroll(_scrollPercent);
            }
        }
        
        public function get scrollPercent():Number
        {
            return _scrollPercent;
        }
        
        private function stage_onMouseWheel(event:MouseEvent):void
        {
            if (event.delta > 0) //向上滚动
            {
                scrollPercent = _scrollPercent >= 0.03 ? (_scrollPercent - 0.03) : 0
            }
            else //向下滚动
            {
                scrollPercent = _scrollPercent >= 0.97 ? 1 : (_scrollPercent + 0.03);
            }
        }
        
        protected function thumb_onMouseDown(btn:IButton):void
        {
            _initData.stage.addEventListener(MouseEvent.MOUSE_MOVE, stage_onMouseMove);
            _initData.stage.addEventListener(MouseEvent.MOUSE_UP, stage_onMouseUp);
        }
        
        protected function stage_onMouseMove(event:MouseEvent):void
        {
            // override by child
        }
        
        private function stage_onMouseUp(event:MouseEvent):void
        {
            _initData.stage.removeEventListener(MouseEvent.MOUSE_MOVE, stage_onMouseMove);
            _initData.stage.removeEventListener(MouseEvent.MOUSE_UP, stage_onMouseUp);
        }
        
        protected function startMoveSpeed():void
        {
            _initData.stage.addEventListener(Event.ENTER_FRAME, onStartMoveSpeed);
            _initData.stage.addEventListener(MouseEvent.MOUSE_UP, onStopMoveSpeed);
        }
        
        protected function onStartMoveSpeed(event:Event):void
        {
            scrollPercent += _curSpeed;
        }
        
        protected function onStopMoveSpeed(event:MouseEvent):void
        {
            _initData.stage.removeEventListener(Event.ENTER_FRAME, onStartMoveSpeed);
            _initData.stage.removeEventListener(MouseEvent.MOUSE_UP, onStopMoveSpeed);
        }
		
	}
}
