package x.game.layer.scene
{
	import flash.display.Sprite;
	
	import x.game.core.IDisposeable;
	
	public interface IAbstractScene extends IDisposeable
	{
//		/** 激活 锁定 场景 */
//		function set activeScene(value:Boolean):void;
		
		/** 场景皮肤 */
		function get skin():Sprite ;
		
		/** 场景渲染 */
		function renderer(dtime:Number):void ;
	}
}