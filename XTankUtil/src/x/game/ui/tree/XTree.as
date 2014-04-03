package x.game.ui.tree
{
    import flash.display.DisplayObject;
    import flash.display.Sprite;
    
    import x.game.ui.XComponent;
    import x.game.ui.scroller.VScroller;
    import x.game.ui.tree.renderer.TreeTrunkRenderer;
    
    
    /**
     * XFlash - XTree
     * 
     * Created By fraser on 2014-2-12
     * Copyright TAOMEE 2014.All rights reserved
     * 组合 treetrunkgroup 和 scroll
     */
    public class XTree extends XComponent
    {
        
        private var _treeHost:ITreeHost ;
        private var _treeInitData:XTreeInitData ;
        private var _trunkGroup:TreeTrunkGroup;
        /** 滚动条 */
        private var _vScroller:VScroller;
        /** 滚动目标初始y位置 */
        private var _initY:Number;
        //
        
        public function XTree($skin:DisplayObject,treeHost:ITreeHost,treeInitData:XTreeInitData)
        {
            super($skin);
            _treeHost = treeHost ;
            _treeInitData = treeInitData ;
            //
            _initY = treeSkin.y;
            //
            _vScroller = new VScroller(skin[treeInitData.scrollerName], onScrollerChange, treeInitData.scrollerInitData);
            _vScroller.scrollPercent = 0;
            //
            _trunkGroup = new TreeTrunkGroup(0, 0);
            _trunkGroup.singleTrunk = false;
            _trunkGroup.addLeafChange(onLeafChange);
            _trunkGroup.addTrunkChange(onTrunkChange);
            _trunkGroup.addUpdateHeightChange(onTrunkHeightUpdateChange);
        }
        
        override public function dispose():void
        {
            _trunkGroup.dispose() ;
            _trunkGroup = null ;
            //
            _vScroller.dispose() ;
            _vScroller = null ;
            //
            _treeHost = null ;
            super.dispose() ;
        }
        
        public function get treeSkin():Sprite 
        {
            return _skin[_treeInitData.treeBoxName] ;
        }
        
        public function get skin():Sprite
        {
            return _skin as Sprite ;
        }
        
        public function addTreeTrunk(trunk:TreeTrunkRenderer):void
        {
            _trunkGroup.addTrunk(trunk);
            _trunkGroup.updateSize();
            onTrunkHeightUpdateChange() ;
        }
        
        private function onScrollerChange(percent:Number = 0):void
        {
            var dValue:Number = treeSkin.height + 10 - _vScroller.height;
            var tmpY:Number = _initY - _vScroller.scrollPercent * dValue;
            if (tmpY <= _initY)
            {
                treeSkin.y = tmpY;
            }
        }
        
        private function onTrunkChange(baseUI:TreeTrunkBaseUI):void
        {
            _treeHost.onTrunkChange(baseUI) ;
        }
        
        private function onLeafChange(group:TreeTrunkGroup):void
        {
            _treeHost.onLeafChange(group.selectedLeafBaesUI) ;
        }
        
        /** 更新树高度 (滚动条更新) */
        private function onTrunkHeightUpdateChange():void
        {
            if (treeSkin.y < _initY)
            {
                if (_vScroller.visible == false)
                {
                    _vScroller.visible = true;
                }
            }
            else if (_trunkGroup != null)
            {
                if (_trunkGroup.totalHeight > 370)
                {
                    if (_vScroller.visible == false)
                    {
                        _vScroller.visible = true;
                    }
                }
                else
                {
                    if (_vScroller.visible == true)
                    {
                        _vScroller.visible = false;
                    }
                }
            }
            onScrollerChange();
        }
    }
}