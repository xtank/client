package x.game.module
{
    import flash.events.EventDispatcher;
    
    import de.polygonal.ds.HashMap;
    import de.polygonal.ds.Itr;
    
    import x.game.enum.PostFix;
    import x.game.manager.VersionManager;
    import x.game.util.ObjectUtil;
    import x.game.util.StringUtil;

    /**
     * 模块管理，创建获取单例应用模块
     * @author tb
     *
     */
    public class ModuleManager
    {
        /** 模块集合 */
        private static var _moduleMap:HashMap = new HashMap();

        /** 获取当前所有开启状态或加载中状态的模块 */
        public static function getAllOpenModule():Vector.<ModuleProxy>
        {
            var result:Vector.<ModuleProxy> = new Vector.<ModuleProxy>();
            
            var itr:Itr = _moduleMap.iterator() ;
            while(itr.hasNext())
            {
                var moduleProxy:ModuleProxy = itr.next() as ModuleProxy ;
                //
                if (moduleProxy.state == ModuleProxy.SHOW || moduleProxy.state == ModuleProxy.LOADING)
                {
                    result.push(moduleProxy);
                }
            }
            return result;
        }

        /**
         * 获取模块状态： 显示、隐藏 、关闭
         * @param name
         * @param subName
         * @return
         *
         */
        public static function getModuleStatus(name:String):String
        {
            var moduleProxy:ModuleProxy = _moduleMap.get(name) as ModuleProxy;
            if (moduleProxy)
            {
                return moduleProxy.state;
            }
            return ModuleProxy.CLOSE;
        }

        /**
         * 获取模块对象
         * @param name
         * @return
         *
         */
        public static function getModule(name:String):AbstractModule
        {
            var moduleProxy:ModuleProxy = _moduleMap.get(name) as ModuleProxy;
            if (moduleProxy)
            {
                return moduleProxy.module;
            }
            return null;
        }
		
		/** 游戏模块资源  */
		private static function getAppModule(name:String):String
		{
			return VersionManager.getURL("modules/" + name + PostFix.SWF);
		}
		
		private static function dealpopWinsBeforeOpenModule(moduleName:String,closeOtherModule:Boolean = true):void
		{
			if (closeOtherModule == true)
			{
				closeModules(Vector.<String>([moduleName]));
			}
		}
		
		// 模块开启条件集合
		private static var _conditions:HashMap = new HashMap() ; 
		
		public static function addOpenModuleCondition(moduleName:String,condition:IOpenModuleCondition):void
		{
			var arr:Vector.<IOpenModuleCondition> = _conditions.get(moduleName) as Vector.<IOpenModuleCondition>;
			if(arr == null)
			{
				arr = new Vector.<IOpenModuleCondition>() ;
				_conditions.set(moduleName,arr) ;
			}
			arr.push(condition) ;
		}
		
		private static function checkOpenModuleConditions(moduleName:String):Boolean
		{
			var rs:Boolean = true ;
			var arr:Vector.<IOpenModuleCondition> = _conditions.get(moduleName) as Vector.<IOpenModuleCondition>;
			if(arr != null)
			{
				var len:uint = arr.length ;
				for(var i:uint = 0;i<len;i++)
				{
					if(arr[i].check(moduleName) == false)
					{
						rs = false ;
						break; 
					}
				}
			}
			return rs ;
		}

        /**
         * 切换显示/隐藏模块
         * @param url
         * @param title
         * @param data
         * @param subName
         *
         */
        public static function toggleModule(moduleName:String, data:IModuleInitData = null, title:String = "正在加载面板，请稍等...", closeOtherModule:Boolean =
            true):ModuleProxy
        {
			if(!checkOpenModuleConditions(moduleName))
			{
				return null ; // 打开条件不满足
			}

			dealpopWinsBeforeOpenModule(moduleName,closeOtherModule) ;
            //
            var url:String = getAppModule(moduleName);
            //
            var moduleProxy:ModuleProxy = _moduleMap.get(StringUtil.getFileName(url)) as ModuleProxy;
            //
            if (moduleProxy != null)
            {
                if (moduleProxy.state == ModuleProxy.SHOW || moduleProxy.state == ModuleProxy.LOADING)
                {
                    moduleProxy.hide();
                }
                else
                {
                    moduleProxy.init(data);
                }
            }
            else
            {
                moduleProxy = createModule(url, title);
                moduleProxy.init(data);
            }

            return moduleProxy;
        }

        /**
         * 显示模块
         * @param url
         * @param title
         * @param data
         * @param subName
         *
         */
        public static function showModule(moduleName:String, data:IModuleInitData = null, title:String = "正在加载面板，请稍等...", closeOtherModule:Boolean =
            true):ModuleProxy
        {
			if(!checkOpenModuleConditions(moduleName))
			{
				return null ; // 打开条件不满足
			}
            //
			dealpopWinsBeforeOpenModule(moduleName,closeOtherModule) ;
            //
            var url:String = getAppModule(moduleName);
            var moduleProxy:ModuleProxy = _moduleMap.get(StringUtil.getFileName(url)) as ModuleProxy;
            if (moduleProxy == null)
            {
                moduleProxy = createModule(url, title);
            }
            moduleProxy.init(data);
            return moduleProxy;
        }
		
		public static function closeModule(moduleName:String):void
		{
			var moduleProxy:ModuleProxy = _moduleMap.get(moduleName) as ModuleProxy ;
			//
			if (moduleProxy != null)
			{
				if (moduleProxy.lifecycleType == LifecycleType.NONCE)
				{
					_moduleMap.remove(moduleProxy.name);
					moduleProxy.dispose();
				}
				else
				{
					moduleProxy.hide();
				}
			}
		}

        private static function closeModules(panelNames:Vector.<String> = null):void
        {
            if (panelNames != null)
            {
                var itr:Itr = _moduleMap.iterator() ;
                while(itr.hasNext())
                {
                    var moduleProxy:ModuleProxy = itr.next() as ModuleProxy ;
                    //
                    if (panelNames.indexOf(moduleProxy.name) == -1)
                    {
                        if (moduleProxy.lifecycleType == LifecycleType.NONCE)
                        {
                            _moduleMap.remove(moduleProxy.name);
                            moduleProxy.dispose();
                        }
                        else
                        {
                            moduleProxy.hide();
                        }
                    }
                }
            }
            else
            {
                closeAllModule();
            }
        }

        /**
         * 创建模块
         * @param url
         * @param title
         * @param data
         * @param subName
         *
         */
        private static function createModule(url:String, title:String):ModuleProxy
        {
            var moduleProxy:ModuleProxy = new ModuleProxy(url, title);
            var name:String = StringUtil.getFileName(url);
            if (_moduleMap.hasKey(name))
            {
                throw new Error("模块名有冲突");
            }
//			Logger.info("创建模块[" + name + "]");
            _moduleMap.set(name, moduleProxy);

            return moduleProxy;
        }

        //--------------------------------------------------------------
        // new
        //--------------------------------------------------------------

        /**
         * 从模块管理中移除模块引，不执行销毁
         * @param name
         * @param subName
         *
         */
        public static function removeModuleByName(name:String):void
        {
            _moduleMap.remove(name);
        }

        /**
         * 关闭全部显示模块
         * @param excepts 需要排除的模块名称
         */
        public static function closeAllModule():void
        {
            var itr:Itr = _moduleMap.iterator() ;
            while(itr.hasNext())
            {
                var moduleProxy:ModuleProxy = itr.next() as ModuleProxy ;
                if (moduleProxy.lifecycleType == LifecycleType.NONCE)
                {
                    _moduleMap.remove(moduleProxy.name);
                    moduleProxy.dispose();
                }
                else
                {
                    moduleProxy.hide();
                }
            }
        }

        /**
         * 关闭当前模块，在模块内部使用
         * @param o
         * @param subName
         *
         */
        public static function closeForInstance(o:Object):void
        {
            closeModule(ObjectUtil.getClassName(o));
        }

        //==========================================================================
        // 			##############  EventDispatcher #################
		//==========================================================================

        private static var _eventDispatcher:EventDispatcher = new EventDispatcher();

        static public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0,
            useWeakReference:Boolean = false):void
        {
            _eventDispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
        }

        static public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void
        {
            _eventDispatcher.removeEventListener(type, listener, useCapture);
        }

        static public function dispatchEvent(name:String, type:String, content:* = null):Boolean
        {
            return _eventDispatcher.dispatchEvent(new ModuleEvent(name, type, content));
        }

        static public function hasEventListener(type:String):Boolean
        {
            return _eventDispatcher.hasEventListener(type);
        }

        static public function willTrigger(type:String):Boolean
        {
            return _eventDispatcher.willTrigger(type);
        }
    }
}
