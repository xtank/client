package x.tank.app.cfg
{
	import flash.ui.ContextMenu;
	
	import x.game.manager.StageManager;
	import x.game.manager.UIManager;
	import x.game.manager.VersionManager;

	public class TankConfig
	{
		static public var rootURL:String;
		/** 是否为调试版本    */
		static public var isDebug:Boolean;
		
		// 右键菜单项
		static public var contextMenu:ContextMenu;
		
		static public function initSystemConfig(obj:Object):void
		{
			rootURL = obj["rootURL"] ;
			isDebug = obj["isDebug"] ;
			contextMenu = obj["contextMenu"] ;
			//
			UIManager.setup(obj["uiDomain"]) ;
			//
			StageManager.fixWidth = obj["fixWidth"] ;
			StageManager.fixHeight = obj["fixHeight"] ;
			StageManager.stage = obj["stage"] ;
			StageManager.root = obj["root"] ;
			VersionManager.setup(obj["versionManager"]) ;
		}
		
		//
		static public var ip:String ;
		static public var port:uint ;
		//
		static public var userId:String ;
		
		static public function initGameConfig(obj:Object):void
		{
			ip = obj["ip"] ;
			port = obj["port"] ;
			userId = obj["userId"] ;
			//
		}
	}
}