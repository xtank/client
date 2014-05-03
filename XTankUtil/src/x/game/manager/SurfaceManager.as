package x.game.manager
{
	import x.game.layer.LayerManager;
	import x.game.surface.BaseSurfaceView;
	import x.game.surface.DefaultTextSurfaceView;

	public class SurfaceManager
	{
		public static function addTextSurface(content:String):void
		{
			addSurface(new DefaultTextSurfaceView(),content) ;
		}
		
		public static function addSurface(view:BaseSurfaceView,args:*):void
		{
			LayerManager.topLayer.addChild(view.surfaceSkin) ;
			view.show(args) ;
		}
	}
}