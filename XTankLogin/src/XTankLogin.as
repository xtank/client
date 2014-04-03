package
{
    import flash.display.Sprite;
    import flash.text.TextField;
    
    import x.game.alert.AlertManager;
    import x.game.log.core.Logger;
    import x.game.manager.TooltipManager;
    import x.game.tooltip.NodesTipSkin;
    import x.game.tooltip.node.BaseNode;
    import x.game.tooltip.node.KeyValueTextNode;
    import x.game.ui.button.IButton;
    import x.game.ui.button.XSimpleButton;
    import x.game.util.Random;
    import x.tank.app.processor.alert.SimpleAlertProcessor;
    import x.tank.login.CheckBox;
    import x.tank.login.LoginUtil;
    import x.tank.login.XtankInitData;
    import x.tank.net.CommandSet;
    
    
    /**
     * XTankLogin - XTankLogin
     * 
     * Created By fraser on 2014-3-11
     * Copyright TAOMEE 2014.All rights reserved
     *
     * #showmodule XTankLogin
     */
    public class XTankLogin extends Sprite
    {
		private var _skin:Sprite ;
		private var _successFun:Function ;
		
        public function XTankLogin()
        {
			_skin = new MainLoginUI() ;
			addChild(_skin) ;
			//
			CommandSet.initCMDS() ;
			//
			initComponent() ;
        }
		
		public function init(initData:Object,successFun:Function):void
		{
			XtankInitData.init(initData) ;
			_successFun = successFun ;
		}
		
		public function get contentWidth():Number
		{
			return 1260;
		}
		
		public function get contentHeight():Number
		{
			return 560;
		}
		
		public function dispose():void
		{
			_successFun = null ;
		}
		
		private var _accountInputTxt:TextField;
		private var _passwordInputTxt:TextField;
		/** 登陆按钮  */
		private var _loginBtn:XSimpleButton;
		/** 记录账号按钮   */
		private var _rememberAccount:CheckBox;
		/** 记录密码按钮  */
		private var _rememberPwd:CheckBox;
		
		private function initComponent():void
		{
			_accountInputTxt = _skin["txtIdInput"];
			_accountInputTxt.restrict = "0-9" ; 
			_accountInputTxt.text = String(Random.random(10000,99999)) ;
			//
			_passwordInputTxt = _skin["txtPwdInput"];
			_passwordInputTxt.displayAsPassword = true;
			_passwordInputTxt.text = "111111" ;
			//
			_loginBtn = new XSimpleButton(_skin["loginBtn"]);
			_loginBtn.grayWhenDisable = true ;
			_loginBtn.addClick(onButtonClick);
			//
			// 1. TooltipManager.addCustomerTipSkin(_loginBtn.skin,new SingleLineTipSkin("我tip系统测试测试测试测试！")) ;
			//
			var nodeDescription:String = 
				KeyValueTextNode.NODE_Name + BaseNode.NODE_START_TAG + "名字1" + BaseNode.NODE_KEY_TAG + "测试1" + 
				BaseNode.NODE_END_TAG + 
				KeyValueTextNode.NODE_Name + BaseNode.NODE_START_TAG + "名字2" + BaseNode.NODE_KEY_TAG + "测试2";
			TooltipManager.addCustomerTipSkin(_loginBtn.skin,new NodesTipSkin(nodeDescription)) ;
			_rememberAccount = new CheckBox(_skin["saveIdBox"], onRemAccountChange);
			_rememberPwd = new CheckBox(_skin["savePwdBox"], onRemPwdChange);
			//
		}
		
		private function onRemAccountChange(box:CheckBox):void
		{
			// SOUtil.writeValueToSO(_rememberAccount.selected ? "1" : "2", XSeerInitDataParser.productName, SOUtil.REM_ACCOUNT_KEY);
		}
		
		private function onRemPwdChange(box:CheckBox):void
		{
			// SOUtil.writeValueToSO(_rememberPwd.selected ? "1" : "2", XSeerInitDataParser.productName, SOUtil.REM_PASSWORD_KEY);
		}
		
		private function onButtonClick(target:IButton):void
		{
			_loginBtn.enable = false ;
			//
			var loginModule:XTankLogin = this ;
			AlertManager.showAlert(1,new SimpleAlertProcessor("弹出框测试？",
				function():void
				{
					var userId:uint = uint(_accountInputTxt.text);
					//
					Logger.info("USERID:" + userId);
					//
					if (target == _loginBtn)
					{
						LoginUtil.actualLogin(loginModule,userId,function():void
						{
							Logger.info("登陆成功！");
							if(_successFun != null)
							{
								_successFun() ;
							}
						},function():void
						{
							_loginBtn.enable = true ;
							Logger.info("登陆失败！") ;
						}) ;
					}
				})) ;
		}
    }
}