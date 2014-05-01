package x.game.surface
{
	import flash.display.Sprite;
	import flash.text.TextField;
	
	import x.game.manager.UIManager;
	import x.game.tween.TweenLite;
	import x.game.ui.XComponent;
	import x.game.util.DisplayObjectUtil;
	
	public class DefaultTextSurfaceView extends XComponent implements ISurfaceView
	{
		private var _txtContent:TextField ;
		
		public function DefaultTextSurfaceView()
		{
			super(UIManager.getSprite("Surface_DefaultFloatView_UI"));
			//
			_txtContent = surfaceSkin["txtContent"] ;
			DisplayObjectUtil.disableTarget(_txtContent) ;
		}
		
		override public function dispose():void
		{
			_txtContent = null ;
			super.dispose() ;
		}
		
		public function get surfaceSkin():Sprite 
		{
			return _skin as Sprite ;
		}
		
		public function show(args:*):void 
		{
			if(args != null)
			{
				_txtContent.text = String(args) ;
			}
			else
			{
				_txtContent.text = "什么也没有!" ;
			}
			//
			TweenLite.to(surfaceSkin,2,{y:surfaceSkin.y - 100,onComplete:function():void{
				DisplayObjectUtil.removeFromParent(surfaceSkin) ;
			}}) ;
		}
	}
}