package x.game.ui.tree.renderer
{
    import x.game.core.IDisposeable;
    import x.game.ui.tree.TreeLeafBaseUI;


    /**
     * @author fraser
     * 创建时间：2012-12-26 下午9:55:14
     * 类说明: 树页
     */
    public class TreeLeafRenderer implements IDisposeable
    {
        /**  子元素Y方向之间的间隔  */
        private var _childIntervalY:Number;
        /** 皮 */
        private var _baseUI:TreeLeafBaseUI;
        /** 统计地址 */
        private var _statisticsTag:* ;

        public function TreeLeafRenderer(baseUI:TreeLeafBaseUI, childIntervalY:Number = 3, statisticsTag:* = null)
        {
            this._baseUI = baseUI;
            this._baseUI.addClick(onLeafClick) ;
            this._childIntervalY = childIntervalY;
            _statisticsTag = statisticsTag ;
        }

        public function dispose():void
        {
            _baseUI.dispose();
            _baseUI = null;
            _statisticsTag = null ;
        }

        private function onLeafClick(ui:TreeLeafBaseUI):void
        {
            if(_statisticsTag != null)
            {
                //StatisticsManager.send(_statisticsTag) ;
            }
        }

        public function reset():void
        {
            _baseUI.selected = false;
        }

        /** 获取当前是否隐藏 */
        public function get visible():Boolean
        {
            return _baseUI.visible ;
        }

        public function set visible(value:Boolean):void
        {
            _baseUI.visible = value ;
        }

        public function get height():Number
        {
            return _baseUI.skin.height + _childIntervalY;
        }

        public function updatePosition(startX:Number, startY:Number):void
        {
            x = startX;
            y = startY;
        }

        public function set x(value:Number):void
        {
            _baseUI.skin.x = value;
        }

        public function set y(value:Number):void
        {
            _baseUI.skin.y = value;
        }

        public function get skin():TreeLeafBaseUI
        {
            return _baseUI;
        }
    }
}

