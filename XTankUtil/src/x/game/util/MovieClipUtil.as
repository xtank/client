package x.game.util
{

	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.FrameLabel;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	
	import x.game.layer.LayerManager;
	import x.game.manager.StageManager;
	import x.game.manager.TooltipManager;

	/**
	 * 影片剪辑 帮助类
	 * @author fraser
	 *
	 */
	public class MovieClipUtil
	{
		/**
		 * 获取swf内容
		 * @param url
		 * @param callBack
		 * @param title
		 *
		 */
		public static function getSwfContent(url:String, callBack:Function, title:String = ""):void
		{
			new MovieClipUtilLoader(url, callBack, title);
		}

		/**
		 * 播放全屏动画
		 * @param url
		 * @param callBack
		 * @param isCloseSound
		 * @param hasSkipBtn
		 * @param initCurrentAnimation
		 *
		 */
		public static function playFullScreen(url:String, callBack:Function = null, initCurrentAnimation:uint = 1):void
		{
//			var skipBtn:XSimpleButton;
			playUrl(url, null, function(mc:MovieClip):void
			{
				LayerManager.topLayer.skin.addChild(mc);
				mc.gotoAndPlay(initCurrentAnimation);
//				if (isShowSkipBtn)
//				{
//					skipBtn = new XSimpleButton(new RES_SkipButtonUI());
//					skipBtn.x = StageManager.fixWidth - skipBtn.width;
//					skipBtn.y = StageManager.fixHeight - skipBtn.height;
//					LayerManager.topLayer.skin.addChild(skipBtn.buttonSkin);
//					skipBtn.addClick(onSkipMovieHandler);
//				}
				//点击跳过按钮操作
//				function onSkipMovieHandler(button:IButton):void
//				{
//					if (callBack != null)
//					{
//						callBack.apply();
//					}
//					stopMcAll(mc);
//					DisplayObjectUtil.removeFromParent(mc);
//					mc = null;
					//
//					if (skipBtn != null)
//					{
//						DisplayObjectUtil.removeFromParent(skipBtn.buttonSkin);
//						skipBtn.dispose();
//						skipBtn = null;
//					}
//				}

			}, function(mc:MovieClip):void
			{
				if (callBack != null)
				{
					callBack.apply();
				}
//				if (skipBtn != null)
//				{
//					DisplayObjectUtil.removeFromParent(skipBtn.buttonSkin);
//					skipBtn.dispose();
//					skipBtn = null;
//				}
				stopMcAll(mc);
				DisplayObjectUtil.removeFromParent(mc);
				mc = null;
			});
		}

		/** 居中播放动画 */
		public static function playMiddle(url:String, callback:Function = null):void
		{
			playUrl(url, null, function(mc:MovieClip):void
			{
				mc.x = StageManager.fixWidth >> 1;
				mc.y = StageManager.fixHeight >> 1;
				LayerManager.topLayer.skin.addChild(mc);
			}, function(mc:MovieClip):void
			{
				if (callback != null)
				{
					callback();
				}
				stopMcAll(mc);
				DisplayObjectUtil.removeFromParent(mc);
				mc = null;
			});
		}

		/** 播放URL动画 */
		public static function playUrl(url:String, parentCon:DisplayObjectContainer = null, startFun:Function = null, endFun:Function = null, isCover:Boolean = false):void
		{
			TooltipManager.hideAll();
			//
			getSwfContent(url, function(mc:MovieClip):void
			{
				playCacheMc(mc, parentCon, startFun, endFun, isCover);
			}, "加载场景动画...");
		}

		public static function playCacheMc(mc:MovieClip, parentCon:DisplayObjectContainer = null, startFun:Function = null, endFun:Function = null, isCover:Boolean = false):void
		{
			TooltipManager.hideAll();
			//
			if (isCover == true)
			{
//				(LayerManager.getLayer(TopLayer.TOP) as TopLayer).showCover();
			}

			playEndAndFunction(mc, function():void
			{
				if (isCover == true)
				{
//                    (LayerManager.getLayer(TopLayer.TOP) as TopLayer).hideCover();
				}

				if (endFun != null)
				{
					endFun.apply(null, [mc]);
				}
				else
				{
					stopMcAll(mc);
					DisplayObjectUtil.removeFromParent(mc);
					mc = null;
				}
			});

			if (parentCon)
			{
				parentCon.addChild(mc);
			}

			if (startFun != null)
			{
				startFun.apply(null, [mc]);
			}
		}

		public static function getChildList(mc:MovieClip, frame:*, childArr:Array, callBack:Function):void
		{
			mc.addEventListener(Event.FRAME_CONSTRUCTED, function(evt:Event):void
			{
				var hasFoundFrame:Boolean = false;
				if (frame is int)
				{
					hasFoundFrame = (int(frame) == mc.currentFrame);
				}
				else if (frame is String)
				{
					hasFoundFrame = (String(frame) == mc.currentLabel);
				}
				if (hasFoundFrame)
				{
					mc.removeEventListener(Event.FRAME_CONSTRUCTED, arguments.callee);
					var children:Vector.<DisplayObject> = new Vector.<DisplayObject>();
					for (var i:int = 0; i < childArr.length; i++)
					{
						var child:DisplayObject;
						if (childArr[i] is int)
						{
							children.push(mc.getChildAt(int(childArr[i])));
						}
						else if (childArr[i] is String)
						{
							children.push(mc.getChildByName(String(childArr[i])));
						}
					}
					callBack(children);
				}
			});
			mc.gotoAndStop(frame);
		}

		private static var _assetIndex:int;
		private static var _assetCount:int;
		private static var _assetVec:Vector.<DisplayObject>;
		private static var _assetCallBack:Function;
		private static var _assetHolder:MovieClip;

		public static function extractAssests(mc:MovieClip, frame:*, count:int, callBack:Function):void
		{
			_assetCount = count;
			_assetCallBack = callBack;
			_assetVec = new Vector.<DisplayObject>();
			MovieClipUtil.getChildList(mc, frame, [0], function(children:Vector.<DisplayObject>):void
			{
				_assetHolder = children[0] as MovieClip;
				_assetIndex = 0;
				extractAssestsHelper();
			});
		}

		private static function extractAssestsHelper():void
		{
			if (_assetIndex == _assetCount)
			{
				_assetCallBack(_assetVec);
			}
			else
			{
				_assetIndex++;
				MovieClipUtil.getChildList(_assetHolder, _assetIndex, [0], function(children:Vector.<DisplayObject>):void
				{
					var child:DisplayObject = children[0];
					var point:Point = child.parent.localToGlobal(new Point(child.x, child.y));
					child.x = point.x;
					child.y = point.y;
					_assetVec.push(child);
					extractAssestsHelper();
				});
			}
		}

		public static function getChild(mc:MovieClip, frame:*, child:*, callBack:Function):void
		{
			mc.addEventListener(Event.FRAME_CONSTRUCTED, function(evt:Event):void
			{
				var hasFoundFrame:Boolean = false;
				if (frame is int)
				{
					hasFoundFrame = (int(frame) == mc.currentFrame);
				}
				else if (frame is String)
				{
					hasFoundFrame = (String(frame) == mc.currentLabel);
				}
				if (hasFoundFrame)
				{
					mc.removeEventListener(Event.FRAME_CONSTRUCTED, arguments.callee);
					if (child is int)
					{
						callBack(mc.getChildAt(int(child)));
					}
					else if (child is String)
					{
						callBack(mc.getChildByName(String(child)));
					}
				}
			});
			mc.gotoAndStop(frame);
		}

		public static function playMc(mc:MovieClip, startFrame:*, endFrame:*, callBack:Function = null):void
		{
			mc.gotoAndPlay(startFrame);
			playEndAndFunction(mc, function():void
			{
				mc.stop();
				if (callBack != null)
				{
					callBack.apply();
				}
			}, endFrame);
		}

		public static function playToEnd(mc:MovieClip, startFrame:*, callBack:Function = null):void
		{
			mc.gotoAndPlay(startFrame);
			playEndAndFunction(mc, callBack);
		}

		/**
		 * 播放完mc并移除
		 * @param mc
		 * @param frame
		 *
		 */
		public static function playEndAndRemove(mc:MovieClip, startFrame:Object = 1, onPlayComplete:Function = null):void
		{
			playEndAndFunction(mc, function():void
			{
				stopMcAll(mc);
				DisplayObjectUtil.removeFromParent(mc);
				mc = null;
				if (onPlayComplete != null)
				{
					onPlayComplete();
				}
			});
			mc.gotoAndPlay(startFrame);
		}

		/** 播放完后回调 */
		public static function playEndAndFunction(mc:MovieClip, backFun:Function = null, frame:Object = -1):void
		{
			frame = frame == -1 ? mc.totalFrames : frame;
			mc.addEventListener(Event.ENTER_FRAME, function onEnter(event:Event):void
			{
				var o:MovieClip = event.currentTarget as MovieClip;

				if (o.currentFrame == frame || o.currentLabel == frame)
				{
					if (backFun != null)
					{
						backFun.apply();
					}

					o.removeEventListener(Event.ENTER_FRAME, arguments.callee);
				}
				else if (o.parent == null)
				{
					o.removeEventListener(Event.ENTER_FRAME, arguments.callee);
				}
			});
		}

		/** 播放到指定帧 */
		public static function gotoAndStop(mc:MovieClip, frame:Object):void
		{
			if (frame as int)
			{
				mc.gotoAndStop(frame);
			}
			else if (frame as String)
			{
				var isGo:Boolean = false;
				var labelList:Array = mc.currentLabels;
				for each (var frameLabel:FrameLabel in labelList)
				{
					if (frameLabel.name == frame)
					{
						mc.gotoAndStop(frameLabel.frame);
						isGo = true;
						break;
					}
				}
				if (isGo == false)
				{
					mc.stop();
				}
			}
			else
			{
				mc.stop();
			}
		}


		/**
		 * lynx
		 * 显示
		 * @param mc
		 * @param frame
		 *
		 */
		public static function showMC(mc:MovieClip, onPlayComplete:Function = null, startFrame:int = 1, endFrame:int = -1):void
		{
			mc.x = int((StageManager.fixWidth - mc.width) / 2);
			mc.y = int((StageManager.fixHeight - mc.height) / 2);
			LayerManager.topLayer.skin.addChild(mc);
			mc.gotoAndPlay(startFrame);
			//
			playEndAndFunction(mc, function():void
			{
				stopMcAll(mc);
				DisplayObjectUtil.removeFromParent(mc);
				mc = null;
				if (onPlayComplete != null)
				{
					onPlayComplete.apply();
				}
			}, endFrame);
		}

		/**
		 * 把动画放在屏幕中央显示，
		 * 此方法适用于的动画是
		 * (0,0)处于动画素材中央位置
		 *
		 */
		public static function showMcInCenterPosition(mc:MovieClip, onPlayComplete:Function):void
		{
			mc.x = StageManager.fixWidth >> 1;
			mc.y = StageManager.fixHeight >> 1;
			LayerManager.topLayer.skin.addChild(mc);
			mc.gotoAndPlay(1);
			mc.addFrameScript(mc.totalFrames - 1, function():void
			{
				stopMcAll(mc);
				DisplayObjectUtil.removeFromParent(mc);
				mc = null;
				if (onPlayComplete != null)
				{
					onPlayComplete();
				}
			});
		}

		/**
		 * 完全停止动画
		 * @param mc
		 */
		public static function stopChild(mc:MovieClip):void
		{
			mc.stop();
			stopAllChildren(mc);
		}

		public static function stopAllChildren(mc:MovieClip):void
		{
			mc.gotoAndStop(1);
			if (mc.numChildren > 0)
			{
				for (var i:int = 0; i < mc.numChildren; i++)
				{
					if (mc.getChildAt(i) as MovieClip)
					{
						stopAllChildren(mc.getChildAt(i) as MovieClip);
					}
				}
			}
		}

		/** 播放影片剪辑的所有的动画*/
		public static function playAllChildren(mc:MovieClip):void
		{
			mc.play();
			var numChildren:int = mc.numChildren;
			
			for (var i:int=0; i<numChildren; i++)
			{
				var child:MovieClip = mc.getChildAt(i) as MovieClip;
				if (child != null)
				{
					playAllChildren(child);
				}
			}
		}
		
		/**
		 * 完全停止动画
		 * @param mc
		 * lynx
		 */
		public static function stopMcAll(mc:MovieClip):void
		{
			var stack:Array = [];
			stack.push(mc);
			while (stack.length != 0)
			{
				var n:DisplayObject = stack.pop();
				if (n is DisplayObjectContainer)
				{
					if (n is MovieClip)
					{
						(n as MovieClip).stop();
					}
					var ns:DisplayObjectContainer = n as DisplayObjectContainer;
					for (var i:int = 0, len:int = ns.numChildren; i < len; i++)
					{
						stack.push(ns.getChildAt(i));
					}
				}
			}
		}
	}
}

import flash.display.MovieClip;

import x.game.core.IDisposeable;
import x.game.loader.UILoader;
import x.game.loader.core.ContentInfo;
import x.game.loader.core.LoadType;
import x.game.loader.core.QueueLoader;

class MovieClipUtilLoader implements IDisposeable
{
	private var _url:String;
	private var _title:String;
	private var _callBack:Function;
	private var _isLoading:Boolean;

	public function MovieClipUtilLoader(url:String, callBack:Function, title:String)
	{
		_url = url;
		_isLoading = true;
		_callBack = callBack;
		QueueLoader.load(_url, LoadType.SWF, onSwfLoadComplete, null, title);
	}

	public function dispose():void
	{
		_url = null;
		_title = null;
		_callBack = null;
	}

	private function onSwfLoadComplete(info:ContentInfo):void
	{
		_isLoading = false;
		if (_callBack != null)
		{
			var mc:MovieClip = info.content as MovieClip;
			_callBack(mc);
			_callBack = null;
		}
		dispose();
	}

	private function onError(info:ContentInfo):void
	{
		if (_callBack != null)
		{
			//_callBack(null);
			_callBack = null;
		}
		dispose();
	}

	public function cancel():void
	{
		if (_isLoading)
		{
			UILoader.cancel(_url, onSwfLoadComplete);
		}
		_callBack = null;
		dispose();
	}
}


