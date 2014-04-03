package x.game.tooltip
{
	import flash.display.Sprite;
	import flash.geom.Point;
	
	import x.game.manager.UIManager;
	import x.game.tooltip.node.BaseNode;
	import x.game.tooltip.node.TipNodeFactory;
	
	/**
	 * @author fraser
	 * 创建时间：2013-8-6下午2:36:32
	 * 类说明：节点构造的tip基类
	 */
	public class NodesTipSkin extends BaseTipSkin
	{
		//
		protected var _curNodePos:Point;
		//
		protected var _startY:uint = 10;
		/** 结点容器集合 */
		protected var _nodeBox:Vector.<Sprite> = new Vector.<Sprite>();
		/** 文字段 */
		protected var _nodeList:Vector.<BaseNode> = new Vector.<BaseNode>();
		
		public function NodesTipSkin(nodeDesc:String,nodeStartPos:Point = null)
		{
			_curNodePos = nodeStartPos == null ? new Point(7, 2) : nodeStartPos;
			super(UIManager.getSprite("TIP_RES_UI_NodesTipSkin"));
			createNode(nodeDesc) ;
		}
				
		override public function dispose():void
		{			
			_nodeBox = null;
			
			for each (var node:BaseNode in _nodeList)
			{
				node.dispose();
			}
			_nodeList = null;
			
			super.dispose();
		}
		
		/** 创建节点 */
		protected function createNode(msg:String):Sprite
		{
			var nodeBox:Sprite = new Sprite();
			// 计算节点的文本描述列表
			var msgList:Array = msg.split(BaseNode.NODE_END_TAG);
			var node:BaseNode;
			var posY:uint = _startY;
			for each (var nodeDescription:String in msgList)
			{
				if (nodeDescription != null && nodeDescription != "")
				{
					var tmp:Array = nodeDescription.split(BaseNode.NODE_START_TAG);
					var head:String = tmp[0];
					var content:String = tmp[1];
					node = TipNodeFactory.createNode(head, content);
					//
					node.nodeSkin.y = posY;
					posY += (node.nodeSkin.height + 2); 
					nodeBox.addChild(node.nodeSkin);
					_nodeList.push(node);
				}
			}
			// --------------------------------------------------------
			nodeBox.x = _curNodePos.x;
			nodeBox.y = _curNodePos.y;
			_curNodePos.y = nodeBox.y + nodeBox.height;
			addChild(nodeBox);
			_nodeBox.push(nodeBox);
			//
			_tipSkin.width = nodeBox.width + 20 ;
			_tipSkin.height = nodeBox.height + 20;
			//
			return nodeBox;
		}
	}
}