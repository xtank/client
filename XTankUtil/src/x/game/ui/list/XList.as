package x.game.ui.list
{
    import flash.display.DisplayObject;
    
    import x.game.ui.XComponent;
    
    
    /**
     * XFlash - XList
     * 
     * Created By fraser on 2014-2-15
     * Copyright TAOMEE 2014.All rights reserved
     * 
     * 列表
     */
    public class XList extends XComponent
    {
        private var _items:Vector.<XListItem> = new Vector.<XListItem>() ;
        
        public function XList(skin:DisplayObject)
        {
            super(skin);
        }
        
        public function addItem(item:XListItem):void
        {
            
        }
        
        override public function dispose():void
        {
            var len:uint = _items.length ;
            for(var i:uint = 0;i<len;i++)
            {
                _items[i].dispose() ;
            }
            _items = null ;
            super.dispose() ;
        }
    }
}