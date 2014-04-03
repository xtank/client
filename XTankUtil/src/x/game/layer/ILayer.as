package x.game.layer
{
	import flash.display.Sprite;

    /**  层级接口  */
	public interface ILayer
	{
		function get skin():Sprite ;
		function get layerName():String ;
	}
}