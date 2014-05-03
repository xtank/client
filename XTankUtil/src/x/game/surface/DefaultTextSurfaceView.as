package x.game.surface
{
	import flash.text.TextField;
	
	import x.game.manager.StageManager;
	import x.game.manager.UIManager;
	import x.game.tween.TweenLite;
	import x.game.util.DisplayObjectUtil;
	
	public class DefaultTextSurfaceView extends BaseSurfaceView
	{
		private var _txtContent:TextField ;
		
		public function DefaultTextSurfaceView()
		{
			super(UIManager.getMovieClip("Surface_DefaultFloatView_UI"));
			//
			_txtContent = surfaceSkin["txtContent"] ;
			DisplayObjectUtil.disableTarget(_txtContent) ;
		}
		
		override public function dispose():void
		{
			_txtContent = null ;
			super.dispose() ;
		}
		
		override public function show(args:*):void 
		{
			DisplayObjectUtil.align(surfaceSkin, StageManager.stageRect);
			if(args != null)
			{
				_txtContent.text = String(args) ;
			}
			else
			{
				_txtContent.text = "什么也没有!" ;
			}
			//
			TweenLite.to(surfaceSkin,1.5,{y:surfaceSkin.y - 100,onComplete:function():void{
				dispose() ;
			}}) ;
		}
	}
}