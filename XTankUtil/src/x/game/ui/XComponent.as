package x.game.ui
{
    import flash.display.DisplayObject;
    import flash.events.Event;
    import flash.events.EventDispatcher;
    
    import x.game.core.IDataClearable;
    import x.game.ui.core.IXComponent;
    import x.game.util.DisplayObjectUtil;

    /**  UI包装类 */
    public class XComponent implements IXComponent, IDataClearable
    {
        /** 皮肤资源 */
        protected var _skin:DisplayObject;
        /** 是否被销毁 */
        protected var _disposed:Boolean;
        /** 携带的数据 */
        protected var _data:Object;
        /** 是否设置为灰色状态 */
        private var _gray:Boolean;

        public function XComponent(skin:DisplayObject)
        {
            _skin = skin;
        }

        public function dataClear():void
        {
            _data = null;
            gray = false;
        }

        public function dispose():void
        {
            _disposed = true;
            //
            DisplayObjectUtil.removeFromParent(_skin);
            _skin = null;
            _data = null;
        }

        public function get visible():Boolean
        {
            return _skin.visible;
        }

        public function set visible(value:Boolean):void
        {
            _skin.visible = value;
        }

        public function get data():Object
        {
            return _data;
        }

        public function set data(value:Object):void
        {
            this._data = value;
        }

        public function get x():Number
        {
            return _skin.x;
        }

        public function set x(value:Number):void
        {
            _skin.x = value;
        }

        public function get y():Number
        {
            return _skin.y;
        }

        public function set y(value:Number):void
        {
            _skin.y = value;
        }

        public function get width():Number
        {
            return _skin.width;
        }

        public function get height():Number
        {
            return _skin.height;
        }

        public function set enable(value:Boolean):void
        {
            throw new Error('must override by child');
        }

        public function get enable():Boolean
        {
            return true;
        }

        public function set gray(value:Boolean):void
        {
            if (_gray != value)
            {
                _gray = value;
                DisplayObjectUtil.enableGray(_skin, _gray);
            }
        }

        public function get gray():Boolean
        {
            return _gray;
        }

        //==========================================================================
        // 			##############  EventDispatcher #################
        //==========================================================================

        private var _eventDispatcher:EventDispatcher = new EventDispatcher();

        public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean =
            false):void
        {
            _eventDispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
        }

        public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void
        {
            _eventDispatcher.removeEventListener(type, listener, useCapture);
        }

        public function dispatchEvent(evt:Event):Boolean
        {
            return _eventDispatcher.dispatchEvent(evt);
        }

        public function hasEventListener(type:String):Boolean
        {
            return _eventDispatcher.hasEventListener(type);
        }

        public function willTrigger(type:String):Boolean
        {
            return _eventDispatcher.willTrigger(type);
        }
    }
}
