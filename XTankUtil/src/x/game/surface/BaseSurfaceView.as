package x.game.surface
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	import x.game.ui.XComponent;
	
	public class BaseSurfaceView extends XComponent implements ISurfaceView
	{
		public function BaseSurfaceView(skin:DisplayObject)
		{
			super(skin);
		}
		
		public function get surfaceSkin():Sprite
		{
			return _skin as Sprite;
		}
		
		public function show(args:*):void
		{
		}
	}
}