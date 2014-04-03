package x.game.ui.core
{
	import x.game.core.IDisposeable;
	
    public interface IXComponent extends IDisposeable
    {		
        function get data():Object ;
        function set data(value:Object):void
        
		/**  */
        function get visible():Boolean;
        function set visible(value:Boolean):void;

		/** X */
        function get x():Number;
        function set x(value:Number):void;

		/** Y */
        function get y():Number;
        function set y(value:Number):void;

		/**  */
        function get width():Number;
        function get height():Number;
		
		/** 是否可用 */
		function set enable(value:Boolean):void;		
		function get enable():Boolean;
		
		/** 灰化不可用状态  */
		function set gray(value:Boolean):void;		
		function get gray():Boolean;
    }
}
