package x.game.ui.tree
{
	import flash.events.Event;
	
	
	/**
	 * @author fraser
	 * 创建时间：2012-12-27 上午11:43:32
	 */
	public class TreeDataEvent extends Event
	{
        public var leaf:TreeLeafBaseUI ;
        
		public function TreeDataEvent(type:String, leaf:TreeLeafBaseUI,bubbles:Boolean=false, cancelable:Boolean=false)
		{
		    super(type, bubbles, cancelable);
            this.leaf = leaf ;
		}
        
        override public function clone():Event
        {
            return new TreeDataEvent(type,leaf,bubbles,cancelable) ;
        }
	}
}