package
{
    import com.taomee.plugins.pandaVersionManager.PandaVersionManager;
    
    import flash.display.DisplayObject;
    import flash.display.Loader;
    import flash.display.LoaderInfo;
    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.events.Event;
    import flash.events.EventDispatcher;
    import flash.events.IOErrorEvent;
    import flash.events.ProgressEvent;
    import flash.net.URLRequest;
    import flash.utils.getDefinitionByName;
    
    import deng.fzip.FZip;
    
    import x.game.cfg.DataProxy;
    import x.game.log.core.Logger;
    import x.game.manager.VersionManager;
    import x.tank.client.DLLLoader;
    import x.tank.client.DllInfo;
    import x.tank.client.XCopyright;
    import x.tank.client.XMLLoader;
    import x.tank.client.model.ClientData;
    import x.tank.client.ui.LoadingBar;
    
    
    /**
     * XTank - XTank
     * 
     * Created By fraser on 2014-3-11
     * Copyright TAOMEE 2014.All rights reserved
     *
     */
	[SWF(width = "960", height = "560", frameRate = 30, backgroundColor = 0x06132e)]
    public class XTank extends Sprite
    {
		// 舞台默认最大宽
		private static const MAX_FIXWIDTH:Number = 960;
		// 舞台默认最小宽 
		private static const MIN_FIXWIDTH:Number = 960;
		
		private var _initData:ClientData ;
		private var _progressBar:LoadingBar;
		
        public function XTank()
        {
            stage != null ? init() : addEventListener(Event.ADDED_TO_STAGE, init);
        }
        
        private function init(e:Event = null):void
        {
            removeEventListener(Event.ADDED_TO_STAGE, init);
			//
			_initData = new ClientData(stage, this, "");
			onResizeHandler(null);
			//
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.stageFocusRect = false;
			stage.addEventListener(Event.RESIZE, onResizeHandler);
			//
			showEnterText("请稍候，正在进入-[X-Tank]...");
			// 初始化进度条
			_progressBar = new LoadingBar();
			_progressBar.loadBg(_initData.rootURL);
			_progressBar.updatePosition(_initData.fixWidth, _initData.fixHeight);
			//
			loadConfig() ;
        }
		
		private function updatePosition():void
		{
			if (_enterTxt != null)
			{
				_enterTxt.updatePosition(_initData.fixWidth, _initData.fixHeight);
			}
			
			if (_progressBar != null)
			{
				_progressBar.updatePosition(_initData.fixWidth, _initData.fixHeight);
			}
			
			if (_mainEntry != null)
			{
				_mainEntry.updatePosition(_initData.fixWidth, _initData.fixHeight);
			}
		}
		
		/** 游戏界面宽高变化 */
		private function onResizeHandler(event:Event):void
		{
			var gameWidth:Number = stage.stageWidth;
			if (gameWidth > MAX_FIXWIDTH)
				stage.stageWidth = MAX_FIXWIDTH;
			//
			_initData.fixWidth = gameWidth;
			//
			gameWidth = gameWidth > MAX_FIXWIDTH ? MAX_FIXWIDTH : gameWidth;
			gameWidth = gameWidth < MIN_FIXWIDTH ? MIN_FIXWIDTH : gameWidth;
			//
			updatePosition();
		}
		// ##########################################################
		// 						tank.xml
		// ##########################################################
		
		private var _xmlloader:XMLLoader;
		private var _dlls:Vector.<DllInfo>;
		private var _versionRUL:String;
		private var _loginSWFURL:String ;
		private var _uiSWFURL:String ;
		private var _cfgURL:String ;
		
		
		private function loadConfig():void
		{
			_progressBar.totalCount = 9 ;
			_progressBar.show(this, false, _initData.fixWidth, _initData.fixHeight);
			_progressBar.loadingTip = "配置文件加载中...";
			//
			_xmlloader = new XMLLoader();
			_xmlloader.load(_initData.rootURL + "config/tank.xml?" + Math.random(), onConfigXMLComplete);
			
			function onConfigXMLComplete(configXML:XML):void
			{
				_progressBar.progressTotal += 1 ;
				//
				_initData.isDebug = (configXML.@debug == 1) ;
				//
				_dlls = new Vector.<DllInfo>() ;
				var dll:XML = configXML.dll[0];
				var xmlList:XMLList = dll.elements();
				for each (var item:XML in xmlList)
				{
					_dlls.push(new DllInfo(item.@name,item.@path)) ;
				}
				//
				_cfgURL = configXML.cfg.@path ;
				_uiSWFURL = configXML.ui.@path ;
				_loginSWFURL = configXML.login.@path ;
				_initData.ip = configXML.login.@ip ;
				_initData.port = configXML.login.@port ;
				//
				_versionRUL = configXML.version.@path;
				//
				loadVersion() ;
			}
		}
		
		// ##########################################################
		// 						Version
		// ##########################################################
		private var _copyright:XCopyright;
		
		private function loadVersion():void
		{
			_progressBar.loadingTip = "版本文件加载中...";
			PandaVersionManager.getInstance().load(_initData.rootURL + _versionRUL, true, null, onVersionComplete);
		}
		
		private function onVersionComplete():void
		{
			_progressBar.progressTotal += 1;
			//
			_copyright = new XCopyright(this, "XTank", "---"); // 版本信息
			_initData.contextMenu = _copyright.contextMenu;
			//
			loadDlls();
		}
		
		// ##########################################################
		// 						Dlls
		// ##########################################################
		private var _dllLoader:DLLLoader;
		
		private function loadDlls():void
		{
			_progressBar.loadingTip = "游戏核心库加载中...";
			_dllLoader = new DLLLoader();
			_dllLoader.doLoad(_dlls, _initData.rootURL, onCUDLLComplete, onChildDLLComplete, onProgress);
			//
			function onChildDLLComplete():void
			{
				_progressBar.progressTotal += 1;
			}
			//
			function onCUDLLComplete():void
			{
				_dllLoader.dispose();
				_dllLoader = null;
				//
				VersionManager.setup(_initData.versionManager);
				//
				loadUI(); 
			}
		}
		
		private function loaderProgress(event:ProgressEvent):void
		{
			onProgress(event.bytesLoaded, event.bytesTotal);
		}
		
		private function onProgress(bytesLoaded:Number, bytesTotal:Number):void
		{
			var percent:int = (bytesLoaded / bytesTotal) * 100;
			_progressBar.progressChild = percent;
		}
		
		private function errorHandler(e:IOErrorEvent):void
		{
			onConnectError("文件加载异常！");
		}
		
		private function onConnectError(msg:String):void
		{
			Logger.error(msg);
		}
		// ##########################################################
		// 						ui
		// ##########################################################
		
		private var _uiLoader:Loader;
		
		private function loadUI():void
		{
			_progressBar.loadingTip = "正在努力加载游戏素材资源";
			_uiLoader = new Loader();
			_uiLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onUIComplete);
			_uiLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
			_uiLoader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, loaderProgress);
			//
			var req:URLRequest = new URLRequest(_initData.rootURL + PandaVersionManager.getVerURLByNameSpace(_uiSWFURL));
			_uiLoader.load(req);
		}
		
		private function onUIComplete(event:Event):void
		{
			_progressBar.progressTotal += 1;
			//
			var loaderInfo:LoaderInfo = event.target as LoaderInfo;
			loaderInfo.removeEventListener(Event.COMPLETE, onUIComplete);
			loaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, errorHandler);
			loaderInfo.removeEventListener(ProgressEvent.PROGRESS, loaderProgress);
			//
			_initData.uiDomain = _uiLoader.contentLoaderInfo.applicationDomain;
			//
			_uiLoader.unloadAndStop();
			_uiLoader = null;
			//
			loadCFG() ;
		}
		
		// ##########################################################
		// 						cfg
		// ##########################################################
		
		private var zip:EventDispatcher; 
		
		private function loadCFG():void
		{
			_progressBar.loadingTip = "正在努力加载游戏配置表";
			zip = new FZip ();
			zip.addEventListener(ProgressEvent.PROGRESS, onZipProgress);
			zip.addEventListener (IOErrorEvent.IO_ERROR, onZipError);
			zip.addEventListener (Event.COMPLETE, onZipComplete);
			(zip as FZip).load (new URLRequest (_initData.rootURL + PandaVersionManager.getVerURLByNameSpace(_cfgURL)));
			//trace(_cfgURL) ;
		}
		
		private function onZipComplete(evt:Event):void 
		{
			_progressBar.progressTotal += 1;
			//
			zip.removeEventListener(ProgressEvent.PROGRESS, onZipProgress);
			zip.removeEventListener (IOErrorEvent.IO_ERROR, onZipError);
			zip.removeEventListener (Event.COMPLETE, onZipComplete);
			//
			DataProxy.init("../cfg/",(zip as FZip)) ;
			//
			initSystem() ;
			loadLogin() ;
		}    
		
		private function onZipProgress(evt:ProgressEvent):void 
		{
			onProgress(evt.bytesLoaded, evt.bytesTotal);
		}
		
		private function onZipError(evt:Event):void 
		{
			Logger.error("cfg.zip load failure!" + evt);
		}
		
		
		// ##########################################################
		// 						Login Page
		// ##########################################################
		private var _loginLoader:Loader;
		private var _loginContent:DisplayObject;
		
		private function loadLogin():void
		{
			_progressBar.loadingTip = "正在努力加载登陆模块...";
			//
			_loginLoader = new Loader();
			_loginLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoginComplete);
			_loginLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
			_loginLoader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, loaderProgress);
			//
			_loginLoader.load(new URLRequest(_initData.rootURL + PandaVersionManager.getVerURLByNameSpace(_loginSWFURL)));
		}
		
		private function onLoginComplete(event:Event):void
		{
			_progressBar.progressTotal += 1 ;
			_progressBar.hide();
			//
			var loaderInfo:LoaderInfo = event.target as LoaderInfo;
			loaderInfo.removeEventListener(Event.COMPLETE, onLoginComplete);
			loaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, errorHandler);
			loaderInfo.removeEventListener(ProgressEvent.PROGRESS, loaderProgress);
			//
			_loginContent = loaderInfo.content;
			_loginContent.x = _initData.fixWidth - _loginContent['contentWidth'] >> 1;
			_loginContent.y = _initData.fixHeight - _loginContent['contentHeight'] >> 1;
			//
			this.addChild(_loginContent);
			_loginContent["init"](_initData, onLoginSuccess);
		}
		
		private function onLoginSuccess(msg:Object):void
		{
			_initData.loginUserObject = msg ;
			//
			this.removeChild(_loginContent);
			//
			_loginLoader.unloadAndStop();
			_loginContent["dispose"]();
			_loginContent = null;
			_loginLoader = null;
			//
			initGame() ;
		}
		
		// ##########################################################
		// 						Game Enter 
		// ##########################################################
		
		private var _mainEntry:Object;
		
		private function initSystem():void
		{
			var mainEntryClass:* = getDefinitionByName("x.tank.app.TankApp");
			_mainEntry = new mainEntryClass();
			_mainEntry.initSystem(_initData) ;
		}
		
		private function initGame():void
		{
			_mainEntry.initGame(_initData);
			//
			_progressBar.dispose();
			_progressBar = null;
			//
			_xmlloader.destroy();
			_xmlloader = null;
			//
			removeChild(_enterTxt);
			_enterTxt = null;
		}
		
		// ##########################################################
		// 						Enter Text
		// ##########################################################
		
		private var _enterTxt:EnterText;
		
		private function showEnterText(t:String):void
		{
			if (_enterTxt == null)
			{
				_enterTxt = new EnterText();
			}
			_enterTxt.setText(t);
			_enterTxt.updatePosition(_initData.fixWidth, _initData.fixHeight);
			this.addChild(_enterTxt);
		}
    }
}

import flash.filters.GlowFilter;
import flash.text.TextField;

class EnterText extends TextField
{
	private var _sw:int;
	private var _sh:int;
	
	public function EnterText()
	{
		selectable = false;
		this.textColor = 0xD0FFFF;
		this.filters = [new GlowFilter(0x1C8CCF)];
//		this.background = true ;
//		this.backgroundColor = 0xFFFFFF ;
	}
	
	public function setText(t:String):void
	{
		htmlText = "<font size='18'>" + t + "</font>";
		width = textWidth + 5;
		height = textHeight + 5;
	}
	
	public function updatePosition(gameWidth:Number, gameHeight:Number):void
	{
		x = (gameWidth - textWidth) / 2;
		y = (gameHeight - textHeight) / 2;
	}
}