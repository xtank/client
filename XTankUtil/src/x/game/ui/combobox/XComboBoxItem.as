package x.game.ui.combobox
{
    import flash.display.Sprite;
    import flash.events.MouseEvent;
    
    import x.game.ui.XComponent;

    public class XComboBoxItem extends XComponent
    {
        private var _onClickHandler:Function ;
        private var _comboBoxItemData:XComboBoxData ;

        public function XComboBoxItem(main:Sprite)
        {
            super(main) ;
            skin.useHandCursor = true ;
            skin.buttonMode = true ;
            skin.addEventListener(MouseEvent.CLICK,onClick) ;
        }

        override public function dispose():void
        {
            skin.removeEventListener(MouseEvent.CLICK,onClick) ;
            _onClickHandler = null ;
            super.dispose() ;
        }
        
        public function get comboBoxItemData():XComboBoxData
        {
            return _comboBoxItemData ;
        }
        
        public function set comboBoxItemData(value:XComboBoxData):void
        {
            _comboBoxItemData = value ;
        }
        
        public function get skin():Sprite 
        {
            return _skin as Sprite ;
        }
		
		public function set width(value:Number):void
		{
			//
		}

        public function set onClickHandler(v:Function):void 
        {
            _onClickHandler = v ;
        }

        private function onClick(event:MouseEvent):void
        {
            if(_onClickHandler != null)
            {
                _onClickHandler(_comboBoxItemData) ;
            }
        }

    }
}

