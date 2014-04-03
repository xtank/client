package x.game.drag
{
	/**
	 * 支持拖拽的接口 
	 * @author fraser
	 * 
	 */
	public interface IDragable
	{
		function dropComplete(drop:Boolean,proxy:DragProxy):void ;
	}
}