package x.game.ui.buttonbar
{
    import flash.display.DisplayObject;
    import flash.display.MovieClip;
    
    import x.game.ui.XComponent;
    import x.game.ui.button.IToggleButton;
    
    
    /**
     * XFlash - XSimpleButtonBar
     * 
     * Created By fraser on 2014-2-9
     * Copyright TAOMEE 2014.All rights reserved
     */
    public class XButtonBar extends XComponent implements IButtonBar
    {
        private var _btns:Vector.<IToggleButton> ;
        private var _selectedBtn:IToggleButton ;
        private var _changFuns:Vector.<Function> ;
        
        public function XButtonBar(skin:DisplayObject)
        {
            super(skin);
            _btns = new Vector.<IToggleButton>() ;
        }
        
        override public function dispose():void
        {
            while(_btns.length > 0)
            {
                _btns.pop().dispose() ;
            }
            _btns = null ;
            _changFuns = null ;
            super.dispose() ;
        }
        
        public function get skin():MovieClip
        {
            return _skin as MovieClip ;
        }
        
        public function get selectedButton():IToggleButton 
        {
            return _selectedBtn ;
        }
        
        // 添加按钮
        public function addButton(button:IToggleButton,isDefaultSelected:Boolean = false) :void
        {
            button.toggle=true;
            button.addClick(changeSelectedElement);
            _btns.push(button);
            if(isDefaultSelected == true)
            {
                changeSelectedElement(button) ;
            }
        }
        //
        public function addChange(fun:Function):void 
        {
            if(_changFuns == null)
            {
                _changFuns = new Vector.<Function>() ;
            }
            var index:int = _changFuns.indexOf(fun) ;
            if(index == -1)
            {
                _changFuns.push(fun) ;
            }
        }
        //
        public function setDefaultSelectedButton(index:uint):void 
        {
            if(index < _btns.length)
            {
                changeSelectedElement(_btns[index]) ;
            }
        }
        //
        public function getButtons():Vector.<IToggleButton> 
        {
            return _btns ;
        }
        
        protected function changeSelectedElement(element:IToggleButton):void
        {
            if(_selectedBtn != null)
            {
                _selectedBtn.selected = false ;
            }
            //
            _selectedBtn = element ;
            if(_selectedBtn != null)
            {
                _selectedBtn.selected = true ;
            }
            //
            for each (var fun:Function in _changFuns)
            {
                fun(this);
            }
        }
    }
}