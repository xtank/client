package x.tank.app.processor.alert
{
	import flash.text.TextField;
	
	import x.game.alert.processor.AlertSkinProcessor;
	import x.game.ui.button.IButton;
	import x.game.ui.button.XSimpleButton;
	import x.game.util.DisplayObjectUtil;
	
	public class SimpleAlertProcessor extends AlertSkinProcessor
	{
		private var _okBtn:XSimpleButton ;
		private var _cancelBtn:XSimpleButton ;
		private var _closeBtn:XSimpleButton ;
		private var _msg:TextField ;
		//
		private var _content:String ;
		private var _onOk:Function ;
		private var _onCancel:Function ;
		private var _onClose:Function ;
		
		public function SimpleAlertProcessor(content:String,onOk:Function = null ,onCancel:Function = null,onClose:Function = null)
		{
			super();
			_content = content ;
			_onOk = onOk ;
			_onCancel = onCancel ;
			_onClose = onClose ;
		}
		
		override protected function processor():void
		{
			super.processor() ;
			_okBtn = new XSimpleButton(_skin["btnOk"]) ;
			_okBtn.addClick(onOkHandler) ;
			_cancelBtn = new XSimpleButton(_skin["btnCancel"]) ;
			_cancelBtn.addClick(onCancelHandler) ;
			_closeBtn = new XSimpleButton(_skin["btnClose"]) ;
			_closeBtn.addClick(onCloseHandler) ;
			//
			_msg = _skin["msgTxt"] ;
			DisplayObjectUtil.disableTarget(_msg) ;
			//
			_msg.text = _content ;
		}
		
		override public function dispose():void
		{
			_okBtn.dispose() ;
			_okBtn = null ;
			_cancelBtn.dispose() ;
			_cancelBtn = null ;
			_closeBtn.dispose() ;
			_closeBtn = null ;
			_msg = null ;
			super.dispose() ;
		}
		
		private function onOkHandler(btn:IButton):void
		{
			if(_onOk  != null)
			{
				_onOk() ;
			}
			_alert.close() ;
		}
		
		private function onCancelHandler(btn:IButton):void
		{
			if(_onCancel  != null)
			{
				_onCancel() ;
			}
			_alert.close() ;
		}
		
		private function onCloseHandler(btn:IButton):void
		{
			if(_onClose  != null)
			{
				_onClose() ;
			}
			_alert.close() ;
		}
	}
}