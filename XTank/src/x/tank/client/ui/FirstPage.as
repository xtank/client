package x.tank.client.ui
{
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;

	/**
	 * @author fraser
	 * 创建时间：2013-10-28上午11:09:05
	 * 类说明：首页
	 */
	public class FirstPage
	{		
		///////////////////////////////////////////////////
		private var _startEnterGame:Function ;
		private var _skin:Sprite ;
		//开始按钮
		private var _startBtn:SimpleButton ;
		//注册按钮
		private var _regBtn:SimpleButton ;
		// 收藏按钮
		private var _collectBtn:SimpleButton ;
		
		private var _btns:Vector.<SimpleButton> = new Vector.<SimpleButton>();
		
		private var _logo:MovieClip ;
		
		public function FirstPage(skin:Sprite,startEnterGame:Function)
		{
			_skin = skin ;
			_startEnterGame = startEnterGame ;
			//
			_startBtn = _skin["startBtn"] ;
			_regBtn = _skin["regBtn"] ;
			_collectBtn = _skin["collectBtn"] ;
			//
			_logo = _skin["logo"] ;
			_logo.mouseEnabled = false ;
			_logo.mouseChildren = false ;
			//
			_startBtn.addEventListener(MouseEvent.CLICK,onStartHandler) ;
			_regBtn.addEventListener(MouseEvent.CLICK,onRegHandler) ;
			_collectBtn.addEventListener(MouseEvent.CLICK,onCollectHandler) ;
			//
			var btn:SimpleButton ;
			for(var i:uint = 0;i<8;i++)
			{
				btn = _skin["btns"]["tbtn_" + i] as SimpleButton ;
				btn.addEventListener(MouseEvent.CLICK,onBtnClick) ;
				_btns.push(btn) ;
			}
		}
		
		public function updatePosition(w:Number,h:Number):void
		{
			w = w > 1260 ? 1260 : w ;
			w = w < 1000 ? 1000 : w ;
			var deX:Number = 1260 - w >> 1 ;
			_logo.x = /*_intro.x =*/ deX ;
			_skin["btns"].x = 1260 - deX ;
			//
			skin.x = w - 1260 >> 1;
		}
		
		private function onBtnClick(event:MouseEvent):void
		{
			var target:SimpleButton = event.currentTarget as SimpleButton ;
			var index:uint = uint(target.name.split("_")[1]) ;
			var linkUrl:String;
			switch(index)
			{
				case 0: // 奥特曼
					linkUrl = "http://atm.61.com/?tad=innermedia.zs.free.homepage_bbanner";
					break;
				case 1:// 赛尔号
					linkUrl = "http://seer.61.com/?tad=innermedia.zs.free.trbanner";
					break;
				case 2://约瑟
					linkUrl = "http://seer2.61.com/?tad=innermedia.zs.free.trbanner";
					break;
				case 3:// 功夫派
					linkUrl = "http://gf.61.com/?tad=innermedia.zs.free.homepage_bbanner";
					break;
				case 4://摩尔庄园
					linkUrl = "http://mole.61.com/?tad=innermedia.zs.free.homepage_bbanner";
					break;
				case 5://小花仙
					linkUrl = "http://hua.61.com/?tad=innermedia.zs.free.homepage_bbanner";
					break;
				case 6://弹弹堂
					linkUrl = "http://event.2125.com/signlink?tmcid=30&gamename=ddt";
					break;
				case 7://创想宾团
					linkUrl = "http://event.2125.com/as_ad?tad=innermedia.zs.free.homepage_bbanner";
					break;
			}
			navigateToURL(new URLRequest(linkUrl), "_blank");
		}
		
		public function get skin():Sprite
		{
			return _skin ;
		}
		
		private function onStartHandler(event:MouseEvent):void
		{
			if(_startEnterGame != null)
			{
				_startEnterGame(0);
			}
		}
		
		private function onRegHandler(event:MouseEvent):void
		{
			if(_startEnterGame != null)
			{
				_startEnterGame(1);
			}
		}
		
		private function onCollectHandler(event:MouseEvent):void
		{
			if (ExternalInterface.available)
			{
				ExternalInterface.call("addBookmark","战神联盟","http://zs.61.com/") ;
			}
		}
		
		public function dispose():void
		{
			while(_btns.length >0 )
			{
				_btns.pop().removeEventListener(MouseEvent.CLICK,onBtnClick) ;
			}
			_btns = null ;
			_startBtn.removeEventListener(MouseEvent.CLICK,onStartHandler) ;
			_regBtn.removeEventListener(MouseEvent.CLICK,onRegHandler) ;
			_collectBtn.removeEventListener(MouseEvent.CLICK,onCollectHandler) ;
			if(_skin.parent != null)
			{
				_skin.parent.removeChild(_skin) ;
			}
			if(_startEnterGame != null)
			{
				_startEnterGame = null ;
			}
		}
	}
}