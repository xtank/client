package x.game.ui.button
{
	import x.game.ui.core.IXComponent;

	public interface IButton extends IXComponent
	{
		/** 手动触发点击事件 */
		function clickManual():void ;
        // 
        function addDownClick(fun:Function):void ;
        function removeDownClick(fun:Function):void ;
        
		/** 添加点击处理  */
		function addClick(fun:Function):void;
		
		/** 移除点击处理  */
		function removeClick(fun:Function):void;
		
		/** 统计标示 */
		function set statisticsTag(value:*):void ;
			
		/** 点击音效 */
		function set soundName(name:String):void;
		
	}
}