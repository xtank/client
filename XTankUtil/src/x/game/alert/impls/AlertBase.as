package x.game.alert.impls
{
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.ui.Mouse;
    import flash.ui.MouseCursor;
    
    import x.game.alert.processor.AlertSkinProcessor;
    import x.game.core.IDisposeable;
    import x.game.drag.MouseDragUtil;
    import x.game.manager.FocusManager;
    import x.game.util.DisplayObjectUtil;


    /**
     * Alert弹框
     *
     * @author fraser
     * 创建时间：2012-12-29上午9:43:24
     */
    public class AlertBase extends Sprite implements IDisposeable
    {
        /** 是否显示 */
        public var showCover:Boolean = true;
        // 加载后显示内容的处理器
        protected var _processor:AlertSkinProcessor;
        // -------------------------------------------------

        public function AlertBase()
        {
            super();
            // 
			addEventListener(MouseEvent.MOUSE_DOWN, onStartDrag);
        }

        public function dispose():void
        {
			removeEventListener(MouseEvent.MOUSE_DOWN, onStartDrag);
            //
            if (_processor != null)
            {
                _processor.dispose();
                _processor = null;
            }

            FocusManager.removeFocus(this);
        }

        public function show():void
        {
            // EffectSoundUtil.play(URLConfig.getOtherSoundEffect("UI_open"));
            //
            FocusManager.setFocus(this);
        }

        //-------------------------------------------------------------------------------------------------------
        private function onStartDrag(e:MouseEvent):void
        {
            Mouse.cursor = MouseCursor.BUTTON;
            var drag:MouseDragUtil = new MouseDragUtil(this);
            drag.addEventListener(MouseDragUtil.DRAG_STOP, onDragStop);
			DisplayObjectUtil.switchToTop(this) ;
        }

        private function onDragStop(e:Event):void
        {
            var drag:MouseDragUtil = e.currentTarget as MouseDragUtil;
            drag.removeEventListener(MouseDragUtil.DRAG_STOP, onDragStop);
            Mouse.cursor = MouseCursor.AUTO;
        }

        /** 初始化处理器 */
        public function initProcessor(processor:AlertSkinProcessor):void
        {
            _processor = processor;
        }

        public function get processor():AlertSkinProcessor
        {
            return _processor;
        }

        /** 关闭面板 */
        public function close():void
        {
            dispatchEvent(new Event(Event.CLOSE));
        }
    }
}


