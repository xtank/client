package
{
	import flash.display.BitmapData;
	import flash.display.Sprite;
	
	import x.game.manager.UIManager;
	
	public class DragTerrian extends Sprite
	{
		public var info:TerrianInfo ;
		
		public function DragTerrian(info:TerrianInfo)
		{
			super();
			this.info = info ;
		}
		
		public function get res():BitmapData
		{
			return UIManager.getBitmapData("Tank_Bg_" + info.id)
		}
	}
}