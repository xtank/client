package x.game.ui.tree.renderer
{
    import flash.events.Event;
    import flash.events.EventDispatcher;
    
    import x.game.core.IDisposeable;
    import x.game.ui.tree.TreeDataEvent;
    import x.game.ui.tree.TreeLeafBaseUI;
    import x.game.ui.tree.TreeTrunkBaseUI;

    /** 展开*/
    [Event(name = "expand", type = "flash.events.Event")]

    /** 收缩 */
    [Event(name = "shrink", type = "flash.events.Event")]

    /** 收缩 */
    [Event(name = "leafSelected", type = "com.taomee.xseer.core.commonUI.tree.TreeDataEvent")]

    /**
     * @author fraser
     * 创建时间：2012-12-26 下午10:05:04
     * 类说明: 树干
     */
    public class TreeTrunkRenderer extends EventDispatcher implements IDisposeable
    {
        /** 孩子 */
        private var _leafs:Vector.<TreeLeafRenderer>;
        /** 皮 */
        private var _baseUI:TreeTrunkBaseUI;
        /** X方向与子元素的距离偏移量*/
        private var _childOffsetX:Number;
        /** Y方向与子元素的距离偏移量*/
        private var _childOffsetY:Number;

        private var _expandFlag:Boolean = false;
        /** 统计地址 */
        private var _statisticsTag:String = "";

        public function TreeTrunkRenderer(baseUI:TreeTrunkBaseUI, 
                                          childOffsetX:Number = 5, 
                                          childOffsetY:Number = 4, 
                                          statisticsTag:String = "")
        {
            _baseUI = baseUI;
            _baseUI.addClick(onClick);
            _baseUI.trunk = this;
            _childOffsetX = childOffsetX;
            _childOffsetY = childOffsetY;
            //
            _leafs = new Vector.<TreeLeafRenderer>();
            _statisticsTag = statisticsTag ;
        }
        
        public function dispose():void
        {
            _baseUI.dispose();
            _baseUI = null;
            //
            for each (var leaf:TreeLeafRenderer in _leafs)
            {
                leaf.dispose();
            }
            _leafs = null;
        }

        public function updatePosition(startX:Number, startY:Number):void
        {
            x = startX;
            y = startY;
            //
            if (_expandFlag == true)
            {
                var tmpX:Number = x + _childOffsetX;
                var tmpY:Number = y + _baseUI.skin.height + _childOffsetY;
                //
                for each (var leaf:TreeLeafRenderer in _leafs)
                {
                    leaf.updatePosition(tmpX, tmpY);
                    tmpY += leaf.height;
                }
            }
        }

        /** 添加子元素  */
        public function addLeaf(leaf:TreeLeafRenderer):void
        {
            leaf.visible = false ;
            leaf.skin.addClick(leafClick);
            //
            _baseUI.skin.parent.addChild(leaf.skin.skin);
            _leafs.push(leaf);
        }

        /**策划特殊需求，隐藏树干和叶子*/
        public function set visible(isVisible:Boolean):void
        {
            _baseUI.skin.visible = isVisible;
            //
            var len:int = _leafs.length;
            for (var i:int = 0; i < len; i++)
            {
                _leafs[i].visible = isVisible ;
            }
        }

        public function getLeaf(data:Object):TreeLeafRenderer
        {
            var rs:TreeLeafRenderer;
            var len:uint = _leafs.length;
            for (var i:uint = 0; i < len; i++)
            {
                if (_leafs[i].skin.compare(data) == true)
                {
                    rs = _leafs[i];
                    break;
                }
            }
            return rs;
        }

        /**
         * 删除所有叶子
         *
         */
        public function removeAllLeafs():void
        {
            shrinkage();
            while (_leafs != null && _leafs.length > 0)
            {
                _leafs.shift().dispose();
            }
        }

        public function resetLeafs():void
        {
            for each (var leaf:TreeLeafRenderer in _leafs)
            {
                leaf.reset();
            }
        }

        private function onClick(button:TreeTrunkBaseUI):void
        {
            if (_expandFlag == true)
            {
                shrinkage();
            }
            else
            {
                expand();
                showFirstLeafRenderer();
                //
                if(_statisticsTag != "")
                {
                    // StatisticsManager.send(_statisticsTag) ;
                }
            }
        }

        /**
         *rockLee 消除按钮状态
         *
         */
        public function unSelectType():void
        {
            _baseUI.selected = false;
        }

        /**
         *rockLee 检测有没有叶子
         * @return
         *
         */
        public function checkHasLeaf():int
        {
            if (!_leafs || _leafs && _leafs.length <= 0)
                return 0;
            return _leafs.length;
        }

        /** 点击叶子 */
        public function leafClick(leaf:TreeLeafBaseUI):void
        {
            this.dispatchEvent(new TreeDataEvent("leafSelected", leaf));
            //
        }

        /** 显示树干下第一个子元素 */
        public function showFirstLeafRenderer():void
        {
            if (_leafs.length > 0)
            {
                this.leafClick(_leafs[0].skin);
            }
        }

        /** 展开 */
        public function expand():void
        {
            _expandFlag = true;
            // 将树叶展开
            for each (var leaf:TreeLeafRenderer in _leafs)
            {
                leaf.visible = true ;
            }
            _baseUI.selected = true;
            //\
            this.dispatchEvent(new Event("expand"));
        }

        /** 收缩 */
        public function shrinkage():void
        {
            _expandFlag = false;
            for each (var leaf:TreeLeafRenderer in _leafs)
            {
                leaf.visible = false ;
            }
            _baseUI.selected = false;
            this.dispatchEvent(new Event("shrink"));
        }

        public function get baseUI():TreeTrunkBaseUI
        {
            return _baseUI;
        }

        public function get height():Number
        {
            if (_baseUI.visible)
            {
                var total:Number = _baseUI.skin.height;
                total += _childOffsetY;
                //
                if (_expandFlag && _leafs.length > 0)
                {
                    for each (var leaf:TreeLeafRenderer in _leafs)
                    {
                        if (leaf.visible)
                        {
                            total += leaf.height;
                        }
                    }
                }
                return total;
            }
            else
            {
                return 0;
            }
        }

        public function set x(value:Number):void
        {
            _baseUI.skin.x = value;
        }

        public function get x():Number
        {
            return _baseUI.skin.x;
        }

        public function get y():Number
        {
            return _baseUI.skin.y;
        }

        public function set y(value:Number):void
        {
            _baseUI.skin.y = value;
        }
    }
}

