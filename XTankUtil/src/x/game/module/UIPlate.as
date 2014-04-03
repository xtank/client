package x.game.module
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	import x.game.core.IDisposeable;
	import x.game.util.DisplayObjectUtil;
	
	/**
	 * @author fraser
	 * 创建时间：2013-4-11下午6:19:11
	 * 类说明：
	 */
	public class UIPlate extends Sprite implements IDisposeable
	{
		private var _plateWidth:uint = 100 ;
		private var _plateHeight:uint = 100 ;
		
		public function UIPlate(plateWidth:uint,plateHeight:uint)
		{
			super();
			_plateWidth = plateWidth ;
			_plateHeight = plateHeight ;
			//
			this.graphics.beginFill(0x000000,0) ;
			this.graphics.drawRect(0,0,_plateWidth,_plateHeight) ;
			this.graphics.endFill() ;
			//
			DisplayObjectUtil.disableTarget(this) ;
		}
		
		public function dispose():void
		{
			DisplayObjectUtil.removeFromParent(this);
			DisplayObjectUtil.removeAllChildren(this) ;
		}
		
		public function setContent(src:DisplayObject):void
		{
			addChild(src) ;
		}
		
		public function get plateWidth():uint
		{
			return _plateWidth ;
		}
		
		public function get plateHeight():uint
		{
			return _plateHeight ;
		}
	}
}