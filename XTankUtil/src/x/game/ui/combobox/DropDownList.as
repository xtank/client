package x.game.ui.combobox
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	import x.game.ui.XComponent;
	import x.game.util.DisplayObjectUtil;
	
	/**
	 * @author fraser
	 * 创建时间：2013-4-16下午3:44:52
	 * 类说明： 下拉框列表
	 */
	public class DropDownList extends XComponent
	{
        // 下拉列表容器
		private var _box:MovieClip ;
        // 背景
		private var _bg:MovieClip ;
		private var _items:Vector.<XComboBoxItem> ;
		//
		private var _fun:Function ;
		
		public function DropDownList(mainUI:MovieClip)
		{
			super(mainUI);
			_bg = skin['bg'] ;
			_box = skin['box'] ;
			//
			DisplayObjectUtil.disableTarget(_bg) ;
			_items = new Vector.<XComboBoxItem>() ;
		}
        
        public function get skin():Sprite 
        {
            return _skin as Sprite ;
        }
		
		public function set width(value:Number):void
		{
			_bg.width = value ;
			for each(var item:XComboBoxItem in _items)
			{
				item.width = value ;
			}
		}
		
		public function setChangeHandler(fun:Function):void
		{
			_fun = fun ;
		}
		
		override public function dispose():void
		{
			super.dispose() ;
			_bg = null ;	
			clearItems() ;
			_items = null ;
			_fun = null ;
		}
		
		public function addItem(item:XComboBoxItem):void
		{
			item.width = _bg.width ;
			item.onClickHandler = onItemClick ;
			_items.push(item) ;
		}	
        
        public function clearItems():void
        {
            while(_items.length > 0)
            {
                _items.pop().dispose() ;
            }
        }
		
		private function onItemClick(data:Object):void
		{
			if(_fun != null)
			{
				_fun(data)  ;
			}
		}	
		
		public function layoutItems():void
		{
			var maxW:Number = 160 ;
			var startX:uint = 3 ;
			var startY:uint = 2 ;
			var len:uint = _items.length ;
			for(var i:uint = 0 ;i<len;i++)
			{
				_items[i].skin.x = startX ;
				_items[i].skin.y = startY ;
				//
				_box.addChild(_items[i].skin) ;
				startY += _items[i].skin.height ;
				if(_items[i].skin.width > maxW)
				{
					maxW = _items[i].skin.width ;
				}
			}
			//
			_bg.width = maxW + 2 * startX ;
			_bg.height = startY + 2 ;
		}
        
		/**通关数据获取选定项*/
		public function getItemByData(data:XComboBoxData):XComboBoxItem
		{
			var tagret:XComboBoxItem;
			for each(var item:XComboBoxItem in _items)
			{
				if(item && item.comboBoxItemData == data)
				{
					tagret = item;
					break;
				}
			}
			return tagret;
		}
				
	}
}