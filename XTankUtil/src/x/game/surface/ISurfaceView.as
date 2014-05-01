package x.game.surface
{
	import flash.display.Sprite;
	
	import x.game.ui.core.IXComponent;

	public interface ISurfaceView extends IXComponent
	{
		function get surfaceSkin():Sprite ; 
		
		function show(args:*):void ;
	}
}