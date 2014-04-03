package x.tank.client
{
	import com.taomee.plugins.pandaVersionManager.PandaVersionManager;
	
	import flash.display.Sprite;
	import flash.events.ContextMenuEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.system.Capabilities;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;

	/**
	 * 游戏右键触发管理
	 * @author fraser
	 *
	 */
	public class XCopyright
	{
		private var _root:Sprite;
		//右键菜单
		private var _contextMenu:ContextMenu;
		private var _contextMenuItem:ContextMenuItem;
		private var _name:String;
		private var _url:String;

		public function XCopyright(root:Sprite, name:String = null, url:String = null)
		{
			// _stage = stage;
			_root = root;
			_name = name;
			_url = url;
			//初始菜单
			_contextMenu = new ContextMenu();
			_contextMenu.hideBuiltInItems();
			_root.contextMenu = _contextMenu;

			initCopyright();
			initXSeerVersion();
			initFlashPlayerVersion();
		}

		public function get contextMenu():ContextMenu
		{
			return _contextMenu;
		}

		private function initFlashPlayerVersion():void
		{
			var contextItem:ContextMenuItem = new ContextMenuItem("您的Flash播放器版本：" + Capabilities.version);
			_contextMenu.hideBuiltInItems();
			_contextMenu.customItems.push(contextItem);
		}

		private function initXSeerVersion():void
		{
			var clientVersionItem:ContextMenuItem = new ContextMenuItem("您的客户端版本：" + getVersionView());
			_contextMenu.customItems.push(clientVersionItem);
		}

		private function initCopyright():void
		{
			//添加名子
			_contextMenuItem = new ContextMenuItem(_name);
			_contextMenuItem.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, onGotoHome);
			_contextMenu.customItems.push(_contextMenuItem);
		}

		private function onGotoHome(event:ContextMenuEvent):void
		{
			navigateToURL(new URLRequest(_url), "_blank");
		}

		/* 获取客户端版本描述字符串 */
		public static function getVersionView():String
		{
			
			var t:Date = PandaVersionManager.getInstance().lastModifiedDate as Date;
			var str:String = t.fullYear + "." + (t.getMonth() + 1) + "." + t.getDate() + " " + t.toTimeString() ;
			return str;
		}
	}
}
