package x.game.manager
{
	import flash.display.InteractiveObject;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.geom.Rectangle;

	/**
	 * @author fraser
	 * 创建时间：2013-11-7下午11:50:29
	 * 类说明：舞台管理器
	 */
	public class StageManager
	{
		/** 游戏视域当前宽 */
		public static var fixWidth:Number = 1260;
		/** 游戏视域当前高 */
		public static var fixHeight:Number = 560;
		/** 游戏舞台 */
		public static var stage:Stage ;
		//
		static public var root:Sprite;
		
		/** 这个矩形会根据舞台尺寸的变化而变化  不可一次性初始化后整个游戏生命周期内使用 */
		public static function get stageRect():Rectangle
		{
			return new Rectangle(0, 0, fixWidth, fixHeight);
		}
        
        /**
         * 获取当前焦点
         * @return
         *
         */
        public static function getFocus():InteractiveObject
        {
            return stage.focus;
        }
	}
}