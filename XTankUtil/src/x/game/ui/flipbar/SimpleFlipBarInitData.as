package x.game.ui.flipbar
{
    
    /**
     * XUIFlash - SimpleFlipBarInitData
     * 
     * Created By fraser on 2014-2-19
     * Copyright TAOMEE 2014.All rights reserved
     */
    public class SimpleFlipBarInitData
    {
        
        /** 当前页 [从0页开始计数] */
        private var _currentPage:int = 0;
        //
        public var totalPage:uint = 0 ;
        /** 一页多少个数据 */
        public var dataCountPerPage:uint = 6;
        // 各种组件的命名
        public var firstBtnName:String = "firstBtn";
        public var lastBtnName:String = "lastBtn";
        public var preBtnName:String = "preBtn";
        public var nxtBtnName:String = "nxtBtn";
        public var txtName:String = "pageTxt";
        //
        public var host:ISimpleFilpBarHost;
        
        public function SimpleFlipBarInitData(dataCountPerPage:uint, totalPage:uint,host:ISimpleFilpBarHost)
        {
            this.dataCountPerPage = dataCountPerPage;
            this.totalPage = totalPage ;
            this.host = host ;
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
        public function changeToPage(page:int):Boolean
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