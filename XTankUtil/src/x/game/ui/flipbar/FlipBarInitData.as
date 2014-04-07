package x.game.ui.flipbar
{

    /**
     * @author fraser
     * 创建时间：2013-7-19下午11:56:50
     * 类说明：todo 添加类注释
     */
    public class FlipBarInitData
    {
        /** 数据 */
        private var _dataList:Array = [];
        /** 当前页 [从0页开始计数] */
        private var _currentPage:uint = 0;
        /** 一页多少个数据 */
        private var _dataCountPerPage:uint = 6;
        
        // 各种组件的命名
        public var firstBtnName:String = "firstBtn";
        public var lastBtnName:String = "lastBtn";
        public var preBtnName:String = "preBtn";
        public var nxtBtnName:String = "nxtBtn";
        public var txtName:String = "pageTxt";
        //
        public var host:IFilpBarHost;
        public var soundName:String = "";

        public function FlipBarInitData(dataCountPerPage:uint, host:IFilpBarHost)
        {
            _dataCountPerPage = dataCountPerPage;
            this.host = host;
			dataProvider = [] ;
        }

        public function set dataProvider(list:Array):void
        {
            if (list == null)
            {
                list = new Array();
            }
            _dataList = list;

            if (currentPage > totalPage)
            {
                _currentPage = 0;
            }
        }

        /** 总页数 */
        public function get totalPage():uint
        {
            var total:uint = Math.ceil(_dataList.length / _dataCountPerPage);
            total = total == 0 ? 1 : total;
            return total;
        }

        /** 当前页数据 */
        public function get currentPageData():Array
        {
            var curData:Array = new Array();
            var startPage:uint = _dataCountPerPage * _currentPage;
            for (var i:uint = 0; i < _dataCountPerPage; i++)
            {
                if (startPage + i < _dataList.length)
                {
                    curData.push(_dataList[startPage + i]);
                }
                else
                {
                    break;
                }
            }
            return curData;
        }

        /** 当前页 */
        public function get currentPage():uint
        {
            return _currentPage + 1;
        }

        /**  下一页 */
        public function next():Boolean
        {
            if (_currentPage + 1 < totalPage)
            {
                _currentPage++;
                return true;
            }
            return false;
        }

        /** 上一页 */
        public function prev():Boolean
        {
            if (_currentPage - 1 >= 0)
            {
                _currentPage--;
                return true;
            }
            return false;
        }

        /** 首页 */
        public function firstPage():Boolean
        {
            return changeToPage(1);
        }

        /** 末页 */
        public function lastPage():Boolean
        {
            return changeToPage(totalPage);
        }

        /** 切换到某页,start from 1 */
        public function changeToPage(page:uint):Boolean
        {
            page--;
            if (page < totalPage)
            {
                _currentPage = page;
                return true;
            }
            return false;
        }
    }
}
