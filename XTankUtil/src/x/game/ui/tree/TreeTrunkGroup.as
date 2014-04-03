package x.game.ui.tree
{
    import flash.events.Event;
    
    import x.game.core.IDisposeable;
    import x.game.ui.tree.renderer.TreeTrunkRenderer;


    /**
     * @author fraser
     * 创建时间：2012-12-26 下午10:26:57
     * 类说明: 树
     */
    public class TreeTrunkGroup implements IDisposeable
    {
        /** 枝干集合  */
        private var _trunks:Vector.<TreeTrunkRenderer> = new Vector.<TreeTrunkRenderer>();
        private var _onLeafChanges:Array = [];
        private var _onHeigthUpdateChanges:Array = [];
        private var _onTrunkChanges:Array = [];
        /** 当前选中的子项 */
        private var _selectedLeafBaesUI:TreeLeafBaseUI;
        // 
        private var _startX:Number = 0;
        private var _startY:Number = 0;
        /** 只能展开一个枝干标志 */
        private var _singleTrunk:Boolean;

        public function TreeTrunkGroup(startX:Number, startY:Number)
        {
            _startX = startX;
            _startY = startY;
        }

        public function dispose():void
        {
            var trunk:TreeTrunkRenderer;
            while (_trunks.length > 0)
            {
                trunk = _trunks.pop();
                trunk.removeEventListener("expand", onExpand);
                trunk.removeEventListener("shrink", onShrink);
                trunk.removeEventListener("leafSelected", onSelected);
                trunk.dispose();
            }
            _onLeafChanges = null;
            _onHeigthUpdateChanges = null;
            _onTrunkChanges = null;
            _selectedLeafBaesUI = null ;
        }

        public function set visible(isVisible:Boolean):void
        {
            var rs:TreeTrunkRenderer;
            var len:uint = _trunks.length;
            for (var i:uint = 0; i < len; i++)
            {
                _trunks[i].visible = isVisible;
            }
        }

        public function getTrunk(data:Object):TreeTrunkRenderer
        {
            var rs:TreeTrunkRenderer;
            var len:uint = _trunks.length;
            for (var i:uint = 0; i < len; i++)
            {
                if (_trunks[i].baseUI.compare(data))
                {
                    rs = _trunks[i];
                    break;
                }
            }
            return rs;
        }

        public function addTrunk(trunk:TreeTrunkRenderer):void
        {
            trunk.addEventListener("expand", onExpand);
            trunk.addEventListener("shrink", onShrink);
            trunk.addEventListener("leafSelected", onSelected);
            trunk.baseUI.addClick(onTrunkChange);
            //
            _trunks.push(trunk);
        }

        /** 点击杆子是被触发 */
        private function onTrunkChange(baseUI:TreeTrunkBaseUI):void
        {
            for each (var fun:Function in _onTrunkChanges)
            {
                fun(baseUI);
            }
        }

        /** 取消选择其他的状态   */
        public function unSelectElseType(type:uint):void
        {
            for each (var renderer:TreeTrunkRenderer in _trunks)
            {
                if (renderer.baseUI.data != type)
                {
                    renderer.unSelectType();
                    //
                    if (renderer.checkHasLeaf() == 0)
                    {
                        renderer.shrinkage();
                    }
                }
            }
        }

        public function addTrunkChange(value:Function):void
        {
            _onTrunkChanges.push(value);
        }

        public function addLeafChange(value:Function):void
        {
            _onLeafChanges.push(value);
        }

        public function addUpdateHeightChange(value:Function):void
        {
            _onHeigthUpdateChanges.push(value);
        }

        private function onSelected(event:TreeDataEvent):void
        {
            for each (var trunk:TreeTrunkRenderer in _trunks)
            {
                trunk.resetLeafs();
            }
            //
            _selectedLeafBaesUI = event.leaf;
            _selectedLeafBaesUI.selected = true;
            //当前选中的item项
            for each (var fun:Function in _onLeafChanges)
            {
                fun(this);
            }
        }

        public function shrinkAll():void
        {
            for each (var trunk:TreeTrunkRenderer in _trunks)
            {
                trunk.shrinkage();
            }
        }

        public function expandAll():void
        {
            if (_singleTrunk == false)
            {
                for each (var trunk:TreeTrunkRenderer in _trunks)
                {
                    trunk.expand();
                    trunk.showFirstLeafRenderer();
                }
            }
        }

        private function onShrink(event:Event):void
        {
            updateSize();
        }

        private function onExpand(event:Event):void
        {
            if (_singleTrunk)
            {
                // 收缩其他枝干
                var target:TreeTrunkRenderer = event.currentTarget as TreeTrunkRenderer;
                //
                for each (var trunk:TreeTrunkRenderer in _trunks)
                {
                    if (target != trunk)
                    {
                        trunk.shrinkage();
                    }
                }
            }
            updateSize();
        }

        /** 总高度 */
        private var _totalHeight:Number = 0;

        public function updateSize():void
        {
            var tmpX:Number = _startX;
            _totalHeight = _startY;
            for each (var trunk:TreeTrunkRenderer in _trunks)
            {
                trunk.updatePosition(tmpX, _totalHeight);
                //
                _totalHeight += trunk.height;
            }
            //			
            for each (var fun:Function in _onHeigthUpdateChanges)
            {
                fun();
            }
        }

        public function get totalHeight():Number
        {
            return _totalHeight;
        }

        public function get selectedLeafBaesUI():TreeLeafBaseUI
        {
            return _selectedLeafBaesUI;
        }

        public function get singleTrunk():Boolean
        {
            return _singleTrunk;
        }

        public function set singleTrunk(value:Boolean):void
        {
            _singleTrunk = value;
            shrinkAll();
        }
    }
}
