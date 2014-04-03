package x.game.tooltip.node
{

    /**
     * @author fraser
     * 创建时间：2013-4-18下午11:11:54
     * 类说明：提示结点工厂
     */
    public class TipNodeFactory
    {
        public static function createNode(nodeName:String, content:String):BaseNode
        {
            var rs:BaseNode;
            switch (nodeName)
            {
                case SimpleTextNode.NODE_Name:
                {
                    rs = new SimpleTextNode(content);
                    break;
                }
                case KeyValueTextNode.NODE_Name:
                {
                    rs = new KeyValueTextNode(content);
                    break;
                }
                case LineNode.NODE_Name:
                {
                    rs = new LineNode(content);
                    break;
                }
                default:
                {
                    throw new Error("未支持的tip结点类型");
                    break;
                }
            }
            return rs;
        }
    }
}
