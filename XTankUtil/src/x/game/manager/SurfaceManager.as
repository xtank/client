package x.game.manager
{
	import flash.events.Event;
	
	import x.game.layer.LayerManager;
	import x.game.surface.DefaultTextSurfaceView;
	import x.game.surface.ISurfaceView;
	import x.game.util.DisplayUtil;

	public class SurfaceManager
	{
		public static function addTextSurface(content:String):void
		{
			addSurface(new DefaultTextSurfaceView(),content) ;
		}
		
		public static function addSurface(view:ISurfaceView,args:*):void
		{
			view.surfaceSkin.addEventListener(Event.REMOVED_FROM_STAGE,function():void{
				view.dispose() ;
				view = null ;
			}) ;
			//
			DisplayUtil.align(view.surfaceSkin,StageManager.stageRect) ;
			LayerManager.topLayer.addChild(view.surfaceSkin) ;
			view.show(args) ;
		}
	}
}