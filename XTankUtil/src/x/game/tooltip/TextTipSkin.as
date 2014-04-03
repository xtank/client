package x.game.tooltip
{
	import flash.display.Sprite;
	import flash.text.TextField;
	
	import x.game.util.DisplayObjectUtil;
	import x.game.util.StringUtil;
	
	
	/**
	 * 文字类提示皮肤基类
	 * 
	 * @author barlow
	 * 创建时间：2013-1-8上午10:42:59
	 */
	public class TextTipSkin extends BaseTipSkin
	{
		protected var _tipTxt:TextField;
		
		public function TextTipSkin(skin:Sprite, tip:String)
		{
			super(skin, tip);
			
			DisplayObjectUtil.disableTarget(_tipTxt) ;
		}
		
		override public function dispose():void
		{
			_tipTxt = null;
			super.dispose();
		}
		
		override protected function initTipView():void
		{
			super.initTipView();
			
			_tipTxt = _tipSkin["txtTip"] as TextField;
//			_tipTxt.border = true ;
//			_tipTxt.borderColor = 0xff0000 ;
		}
		
		override protected function updateTipView():void
		{
			if(_initData)
			{
				_tipTxt.htmlText = StringUtil.replace(tip, "\\n", "<br>");
				_tipTxt.width = _tipTxt.textWidth + 10;
				_tipTxt.height = _tipTxt.textHeight + 10;
			}
			else
			{
				_tipTxt.htmlText = "" ;
			}
		}
		
		protected function get tip():String
		{
			return _initData as String;
		}
	}
}