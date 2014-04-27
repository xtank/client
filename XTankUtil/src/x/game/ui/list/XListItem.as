package x.game.ui.list
{
    import flash.display.DisplayObject;
    import flash.display.MovieClip;
    
    import x.game.ui.XComponent;
    
    
    /**
     * XFlash - XListItem
     * 
     * Created By fraser on 2014-2-15
     * Copyright TAOMEE 2014.All rights reserved
     * 
     * 列表项包装
     */
    public class XListItem extends XComponent
    {
		private var _selected:Boolean = false ;
		
        public function XListItem(skin:DisplayObject)
        {
            super(skin);
			selected = false ;
        }
		
		public function get skin():MovieClip
		{
			return _skin as MovieClip ;
		}
		
		public function get selected():Boolean
		{
			return _selected ;
		}
		
		public function set selected(value:Boolean):void
		{
			_selected = value ;
		}
        
        // 根据新刷入的数据  更新视图
        protected function updateItemView():void
        {
            
        }
        
        // 无数据时显示的内容
        protected function updateNullDataItemView():void
        {
            
        }
        
        override public function dataClear():void
        {
            super.dataClear() ;
            updateNullDataItemView() ;
        }
        
        override public function set data(value:Object):void
        {
            if(value != data)
            {
                super.data = value ;
                if(data != null)
                {
                    updateItemView() ;
                }
                else
                {
                    updateNullDataItemView() ; 
                }
            }
        }
    }
}