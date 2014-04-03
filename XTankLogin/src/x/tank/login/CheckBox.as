package x.tank.login
{
    import flash.display.MovieClip;
    import flash.events.MouseEvent;

    /**
     * 多选框
     * @author fraser
     *
     */
    public class CheckBox
    {
        private var _selected:Boolean = true ;
        private var _ui:MovieClip ;
        private var _onChange:Function ;

        public function CheckBox(ui:MovieClip,onChange:Function)
        {
            _ui = ui ;
            _ui.addEventListener(MouseEvent.CLICK,onClick);
			_onChange = onChange ;
        }

        private function onClick(event:MouseEvent):void
        {
			selected = !selected ;
			if(_onChange != null)
			{
				_onChange(this) ;
			}
        }

        public function updateUI():void
        {
            if(selected)
            {
                _ui.gotoAndStop(1) ;
            }
            else
            {
                _ui.gotoAndStop(2) ;
            }
        }

        public function dispose():void
        {
            _ui.removeEventListener(MouseEvent.CLICK,onClick);
            _ui = null ;
        }

        public function get selected():Boolean
        {
            return _selected;
        }

        public function set selected(value:Boolean):void
        {
            _selected = value;
            updateUI() ;
        }

    }
}

