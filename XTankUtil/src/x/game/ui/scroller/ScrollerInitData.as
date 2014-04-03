package x.game.ui.scroller
{
    import flash.display.Stage;

    /**
     * @author fraser
     * 创建时间：2013-7-20上午10:38:09
     * 类说明：todo 添加类注释
     */
    public class ScrollerInitData
    {
        public var stage:Stage;
        /** 是否支持范围内自动隐藏 */
        public var autoVisible:Boolean = false;
        /** 是否支持滚轮操作 */
        public var isMouseWheel:Boolean = false;
		//
		public var upBtnName:String = "upBtn" ;
		public var downBtnName:String = "downBtn" ;
		public var sliderBtnName:String = "sliderBtn" ;
		public var trackName:String = "track" ;
		//
		/** 滚动速度 */
		public var speed:Number = 0.05;
		
		public function ScrollerInitData($stage:Stage)
		{
			stage = $stage ;
		}
    }
}
