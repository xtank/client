package x.game.ui.combobox
{
    import flash.display.MovieClip;
    import flash.display.SimpleButton;
    import flash.display.Sprite;
    import flash.events.MouseEvent;
    
    import x.game.ui.XComponent;
    import x.game.ui.button.IToggleButton;
    import x.game.ui.button.XButton;
    import x.game.ui.button.XToggleButton;
    import x.game.util.DisplayObjectUtil;

    /**
     * @author fraser
     * 创建时间：2013-4-16下午3:39:18
     * 类说明：下拉框
     */
    public class XComboBox extends XComponent
    {
        private var _downButton:IToggleButton;
        private var _titleBg:MovieClip;
        private var _defaultItemBox:XComboBoxItem;
        //
        private var _dropDownList:DropDownList;
        //
        private var _itemClss:Class;
        //
        private var _funs:Vector.<Function> = new Vector.<Function> ;
        //
        public function XComboBox($skin:Sprite ,initData:XComboBoxInitData)
        {
            super($skin);
            data = initData ;
            //
            _titleBg = skin[initData.titleBg_SkinName];
            _titleBg.addEventListener(MouseEvent.CLICK, onTitleClickHandler);
            //
            if(skin[initData.downBtn_SkinName] is SimpleButton)
            {
                _downButton = new XToggleButton(skin[initData.downBtn_SkinName]);
            }
            else
            {
                _downButton = new XButton(skin[initData.downBtn_SkinName]) ;
                _downButton.toggle = true ;
            }
            _downButton.addClick(onDownList);
            //
            _dropDownList = new DropDownList(skin[initData.listBox_SkinName]);
            _dropDownList.setChangeHandler(dropDownListChange);
            _dropDownList.visible = false ;
            //
            _itemClss = initData.itemClass;
            if (_itemClss == null)
            {
                _itemClss = SimpleTxtComboItem;
            }
            // 
            var defaultItem:XComboBoxItem = initData.defaultItem;
            if (defaultItem == null)
            {
                defaultItem = new _itemClss();
            }
            _defaultItemBox = defaultItem;
            DisplayObjectUtil.disableTarget(_defaultItemBox.skin);
            _defaultItemBox.skin.x = 4;
            _defaultItemBox.skin.y = 4;
            skin.addChild(_defaultItemBox.skin);
        }
        
        public function get skin():Sprite 
        {
            return _skin as Sprite ;
        }

        override public function dispose():void
        {
            super.dispose();
            _titleBg.removeEventListener(MouseEvent.CLICK, onTitleClickHandler);
            _defaultItemBox.dispose();
            _downButton.dispose();
            _dropDownList.dispose();
            //
            _defaultItemBox = null;
            _downButton = null;
            _dropDownList = null;
            _itemClss = null;
            _titleBg = null;
        }
        
        public function showList():void
        {
            _dropDownList.visible = true ;
            _downButton.selected = true;
        }
        
        public function hideList():void
        {
            _dropDownList.visible = false ;
            _downButton.selected = false;
        }
		
		public function set width(value:Number):void
		{
			_titleBg.width = value ;
			_dropDownList.width = value ;
			_downButton.x = value - _downButton.width - 4 ;
		}

        /** 收缩下拉列表  */
        public function shrinkDropDownList():void
        {
            if (_downButton.selected)
            {
                _downButton.clickManual();
            }
        }
        
        // 默认项是否可见
        public function unvisibleDefaultItemBox():void
        {
            _defaultItemBox.skin.visible = false;
        }

        public function addOnChange(fun:Function):void
        {
            _funs.push(fun);
        }

        /**获取当前选择项数值*/
        public function get selectedItem():XComboBoxData
        {
            var targeData:XComboBoxData = null;
            if (_defaultItemBox)
                targeData = _defaultItemBox.comboBoxItemData;
            return targeData;
        }

        /**通关数据设置当前选定项*/
        public function set selectedItem(data:XComboBoxData):void
        {
            var item:XComboBoxItem = _dropDownList.getItemByData(data);
            if (item)
                dropDownListChange(item.comboBoxItemData);
        }

        public function set defaultItemData(data:XComboBoxData):void
        {
            _defaultItemBox.comboBoxItemData = data;
        }

        public function set dataProvoider(data:Vector.<XComboBoxData>):void
        {
            _dropDownList.clearItems();
            //
            var len:uint = data.length;
            if (len > 0)
            {
                for (var i:uint = 0; i < len; i++)
                {
                    var item:XComboBoxItem = new _itemClss();
                    item.comboBoxItemData = data[i];
                    _dropDownList.addItem(item);
                }
            }
            _dropDownList.layoutItems();
        }
        
        private function dropDownListChange(data:XComboBoxData):void
        {
            shrinkDropDownList();
            defaultItemData = data;
            //
            var len:uint = _funs.length;
            for (var i:uint = 0; i < len; i++)
            {
                _funs[i](data);
            }
        }
        
        private function onTitleClickHandler(event:MouseEvent):void
        {
            _downButton.clickManual();
        }

        private function onDownList(btn:IToggleButton):void
        {
            _dropDownList.visible = btn.selected ;
        }
    }
}
