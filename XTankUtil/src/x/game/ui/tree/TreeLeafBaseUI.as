package x.game.ui.tree
{
	import flash.display.MovieClip;
	
	import x.game.ui.button.XButton;
	
	
	/**
	 * @author fraser
	 * 创建时间：2012-12-27 上午11:34:25
	 * 类说明: 活动UI 树形结构叶子皮肤基类
	 */
	public class TreeLeafBaseUI extends XButton
	{
		public function TreeLeafBaseUI(mainUI:MovieClip, data:Object = null)
		{
		    super(mainUI,data);
            toggle = true ;
            initComponents() ;
            updateLeaf() ;
		}
        
        protected function initComponents():void
        {
            
        }
		
		public function updateLeaf():void
		{
			// override by child 更新显示
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