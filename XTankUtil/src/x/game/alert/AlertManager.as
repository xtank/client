package x.game.alert
{
    import flash.display.DisplayObjectContainer;
    import flash.display.Sprite;
    import flash.events.Event;
    
    import x.game.alert.impls.AlertBase;
    import x.game.alert.impls.ImageAlert;
    import x.game.alert.processor.AlertSkinProcessor;
    import x.game.manager.StageManager;
    import x.game.util.DisplayObjectUtil;
    import x.game.util.DisplayUtil;

    /**
     * 提示管理器
     * @author fraser
     */
    public class AlertManager
    {
        /**  图形 Alert */
        public static function showAlert(iD:uint, processor:AlertSkinProcessor = null):ImageAlert
        {
            var alert:ImageAlert = new ImageAlert(iD);
            alert.initProcessor(processor);
            return addAlert(alert) as ImageAlert;
        }

        // ############################################################
        // 							当前弹出列表
        // ############################################################
        /** 当前弹出提示窗口  */
        private static var _currAlert:AlertBase;
        /** 提示弹出窗口所在容器  */
        private static var _alertBox:DisplayObjectContainer;
        /** 提示框队列   */
        private static var _alertList:Vector.<AlertBase>;
        private static var _coverShape:Sprite;

        public static function setup(alertCon:Sprite):void
        {
            _alertBox = alertCon;
            _alertList = new Vector.<AlertBase>();
        }

        /** 添加Alert到显示列表 */
        private static function addAlert(alert:AlertBase):AlertBase
        {
            _alertList.push(alert);
            nextAlert();
            return alert;
        }

        /** 清空Alert */
        public static function removeAllAlert():void
        {
            for each (var alert:AlertBase in _alertList)
            {
                alert.removeEventListener(Event.CLOSE, onCloseAlert);
                alert.dispose();
                DisplayObjectUtil.removeFromParent(alert);
            }
            _alertList.length = 0;
            //
            if (_currAlert != null)
            {
                _currAlert.close();
            }
        }

        private static function nextAlert():void
        {
            if (_alertList.length && _currAlert == null)
            {
                _currAlert = _alertList.shift();
                _currAlert.show();
                _alertBox.addChild(_currAlert);
                //
                if (_currAlert.showCover)
                {
                    _alertBox.addChildAt(getCoverShape(), 0);
                }
                // 监听关闭事件
                _currAlert.addEventListener(Event.CLOSE, onCloseAlert);
            }
        }

        private static function getCoverShape():Sprite
        {
            if (_coverShape == null)
            {
                _coverShape = new Sprite();
            }
            _coverShape.graphics.clear();
            _coverShape.graphics.beginFill(0x000000, .2);
            _coverShape.graphics.drawRect(0, 0, 1260, 560);
            _coverShape.graphics.endFill();
            return _coverShape;
        }

        private static function onCloseAlert(e:Event):void
        {
            DisplayObjectUtil.removeFromParent(_coverShape);
            removeAlert(e.currentTarget as AlertBase);
            nextAlert();
        }

        /** 移除弹框 */
        private static function removeAlert(alert:AlertBase):void
        {
            alert.removeEventListener(Event.CLOSE, onCloseAlert);
            alert.dispose();
            //
            DisplayObjectUtil.removeFromParent(alert);

            var alertIdx:int = _alertList.indexOf(alert);
            if (alertIdx != -1)
            {
                _alertList.splice(alertIdx, 1);
            }

            if (_currAlert == alert)
            {
                _currAlert = null;
            }
        }
    }
}


