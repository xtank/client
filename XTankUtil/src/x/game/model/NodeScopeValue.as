package x.game.model
{


    /**
     * 节点范围VO
     * @author fraser
     *
     */
    public class NodeScopeValue extends ScopeValue
    {
		
		public static function createNodeScopeValue(description:String,min:int,max:int, data:Object = null):NodeScopeValue
		{
			return new NodeScopeValue(description,min,max,data) ;
		}
		
		
		// ==================================================================================
		// 
		// ==================================================================================
		
        /** 此范围对应的描述 */
        public var description:String ; 
        /** 此范围下的子范围集合 */
        public var nodes:Vector.<NodeScopeValue> = new Vector.<NodeScopeValue>() ;

        public function NodeScopeValue(description:String,min:uint,max:uint, data:Object = null)
        {
            super(min,max,data) ;
            this.description = description ;
        }

        override public function dispose():void
        {
            super.dispose() ;
            description = null ;
            while(nodes.length > 0)
            {
                nodes.pop().dispose() ;
            }
        }

        /** 添加子范围节点  */
        public function addNode(scope:NodeScopeValue):void
        {
            nodes.push(scope) ;
        }

        /** 根据道具的id编号返回范围对象 */
        public function getChildNodeScope(value:uint):NodeScopeValue
        {
            if(nodes == null)
                return this ;
            //
            var result:NodeScopeValue;
            var len:uint = nodes.length;
            var scope:NodeScopeValue;
            for (var i:uint = 0; i < len; i++)
            {
                scope = nodes[i];
                if (scope.isInScope(value) == true)
                {
                    result = scope;
                    break;
                }
            }
            return result;
        }
    }
}

