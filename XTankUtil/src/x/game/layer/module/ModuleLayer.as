package x.game.layer.module
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	
	import x.game.manager.StageManager;
	import x.game.module.Module;
	import x.game.tween.TweenLite;
	import x.game.util.DisplayObjectUtil;
	import x.game.layer.CoverUI;
	import x.game.layer.ILayer;

	/**
	 * 模块层
	 * @author fraser
	 *
	 */
	public class ModuleLayer implements ILayer
	{
		/**  模块显示层   */
		public static const INDEX:uint = 2;
		/** 层容器 */
		private var _layerSkin:Sprite;
		/** 当前所有显示中的模块列表   */
		private var _showModules:Array = [];

		public function ModuleLayer(rootContainer:DisplayObjectContainer)
		{
			_layerSkin = new Sprite();
			_layerSkin.mouseEnabled = false;
			//
			rootContainer.addChild(_layerSkin);
		}

		public function get layerName():String
		{
			return "module-layer";
		}

		public function get skin():Sprite
		{
			return _layerSkin;
		}

		/**
		 * 添加显示模块
		 * @param value
		 *
		 */
		public function addModule(module:Module):void
		{
			module.alpha = 1;
			_showModules.push(module);
			//
			if (module.cover)
			{
				if (CoverUI.isCover(this) == false)
				{
					CoverUI.showCover(this);
				}
			}
			//
			// 居中显示模块
			if (module.isAutoAlign)
			{
				module.x = StageManager.fixWidth - module.moduleWidth >> 1;
				module.y = StageManager.fixHeight - module.moduleHeight >> 1;
			}
			else
			{
				module.customPosition();
			}
			_layerSkin.addChild(module);
		}

		/**
		 * 移除模块
		 * @param value
		 *
		 */
		public function removeModule(module:Module):void
		{
			var index:uint = _showModules.indexOf(module);
			if (index != -1)
			{
				_showModules.splice(index, 1);
				checkHideCoverUI();
			}
			//
			if (module.isPlayShowEffect)
			{
				var tween:TweenLite = TweenLite.to(module, .5, {alpha: 0, onComplete: onHideComplete});
			}
			else
			{
				DisplayObjectUtil.removeFromParent(module);
			}
			//
			function onHideComplete():void
			{
				tween.kill();
				tween = null;
				//
				DisplayObjectUtil.removeFromParent(module);
			}
		}

		private function checkHideCoverUI():void
		{
			var hasCoverModule:Boolean = false;
			var len:uint = _showModules.length;
			var module:Module;
			for (var i:uint = 0; i < len; i++)
			{
				module = _showModules[i];
				if (module.cover == true)
				{
					hasCoverModule = true;
					break;
				}
			}
			//
			if (hasCoverModule == false)
			{
				CoverUI.hideCover(this);
			}
		}
	}
}
