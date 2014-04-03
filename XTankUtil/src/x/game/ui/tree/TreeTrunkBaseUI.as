package x.game.ui.tree
{
	import flash.display.MovieClip;
	
	import x.game.ui.button.XButton;
	import x.game.ui.tree.renderer.TreeTrunkRenderer;
	
	
	/**
     * 
	 * @author fraser
	 * 创建时间：2012-12-26 下午10:32:46
	 * 类说明: 树状枝干皮肤基类
	 */
	public class TreeTrunkBaseUI extends XButton
	{
        public var trunk:TreeTrunkRenderer ;
        
		public function TreeTrunkBaseUI(mainUI:MovieClip, data:Object = null)
		{
		    super(mainUI,data);
            toggle = true ;
		}
        
        override public function dispose():void
        {
            trunk = null ;
            super.dispose() ;
        }
		
		// override by child 
		public function compare(d:Object):Boolean
		{
			if(d == data)
			{
				return true ;
			}
			else
			{
				return false ;
			}
		}
	}
}