package x.game.drag
{
	import flash.display.Sprite;

	/**
	 * 支持放置拖拽的接口 
	 * @author fraser
	 * 
	 */
	public interface IDropable
	{
		function drop(dragProxy:DragProxy):Sprite ;
	}
}