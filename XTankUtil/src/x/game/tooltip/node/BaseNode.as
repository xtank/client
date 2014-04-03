package x.game.tooltip.node
{
    import flash.display.Sprite;
    
    import x.game.ui.XComponent;
    import x.game.util.DisplayObjectUtil;

    /**
     * @author fraser
     * 创建时间：2013-3-20下午6:08:51
     * 类说明：
	 * 	节点构造：
	 * 		[nodeType] NODE_START_TAG [nodeargs1] NODE_KEY_TAG [nodeargs2] NODE_KEY_TAG [nodeargs3]
     */
    public class BaseNode extends XComponent
    {
        public static const NODE_START_TAG:String = "\h" ; 	// 节点头的分割符号
        public static const NODE_KEY_TAG:String = "\t" ; 	// 节点参数的分隔符号 (对应每个节点)
        public static const NODE_END_TAG:String = "\n" ; 	// 节点间的分隔符号

        public function BaseNode(sp:Sprite)
        {
            super(sp);
            DisplayObjectUtil.disableTarget(nodeSkin) ;
        }
		
		public function get nodeSkin():Sprite
		{
			return _skin as Sprite;
		}
    }
}

