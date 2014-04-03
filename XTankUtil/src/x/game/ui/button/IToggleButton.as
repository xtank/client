package x.game.ui.button
{
	public interface IToggleButton extends IButton
	{
		/** 当前是否处于选中状态 */
		function get selected():Boolean;	
        
        function set selected(value:Boolean):void ;
        
        function set toggle(value:Boolean):void ;
        
        function get toggle():Boolean ;
	}
}