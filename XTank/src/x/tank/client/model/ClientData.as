package x.tank.client.model
{
	import com.taomee.plugins.pandaVersionManager.PandaVersionManager;
	
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.system.ApplicationDomain;
	import flash.ui.ContextMenu;

	public class ClientData
	{
		
		/** 舞台当前宽 */
		public var fixWidth:Number = 1260;
		/** 舞台当前高 */
		public var fixHeight:Number = 560;
		public var stage:Stage;
		public var root:Sprite;
		// 右键菜单项
		public var contextMenu:ContextMenu;
		//
		public var rootURL:String;
		/** 是否为调试版本    */
		public var isDebug:Boolean;
		/** 版本控制对象  */
		public var versionManager:Object;
		//
		public var uiDomain:ApplicationDomain ;
		//
		public var ip:String ;
		public var port:uint ;
		//
		public var userId:String ;
		
		public function ClientData(stage:Stage, root:Sprite, rootURL:String)
		{
			this.stage = stage;
			this.root = root;
			this.rootURL = rootURL;
			versionManager = PandaVersionManager ;
		}
	}
}