package x.game.tooltip.node
{
    import x.game.manager.UIManager;

    /**
     * @author fraser
     * 创建时间：2013-5-30下午6:21:53
     * 类说明：
     */
    public class LineNode extends BaseNode
    {
        public static const NODE_Name:String = "LINE";

        public function LineNode(content:String)
        {
            super(UIManager.getSprite("Tip_RES_UI_LineNode"));
        }
    }
}


