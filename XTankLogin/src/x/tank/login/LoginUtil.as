package x.tank.login
{
	import onlineproto.cs_enter_server;
	import onlineproto.sc_enter_server;
	
	import x.game.log.core.Logger;
	import x.game.net.Connection;
	import x.game.net.post.SimpleCallbackPost;
	import x.game.net.response.XMessageEvent;



	public class LoginUtil
	{

		public static function actualLogin(swfLogin:XTankLogin,userId:int, onLoginSuccess:Function, onLoginError:Function):void
		{
			// 连接登陆服务器 
			LoginServerAgent.connectServer(
				userId,
				XtankInitData.getDataByKey("ip") as String, 
				uint(XtankInitData.getDataByKey("port")),
				connectSuccess);

			// 链接成功
			function connectSuccess():void
			{
				Logger.info("#####################################");
				Logger.info("userId #[" + userId + "]");
				Logger.info("#####################################");
				
				Connection.setConnectInfo(userId) ;
				
				var msg:cs_enter_server = new cs_enter_server() ;
				msg.userid = userId ;
				new SimpleCallbackPost(101,msg,$onLoginSuccess,$onLoginError).send() ;
			}

			function $onLoginSuccess(event:XMessageEvent):void
			{
				// var userId:uint=event.response.userId;
				var msg:sc_enter_server = event.msg as sc_enter_server;
				if (onLoginSuccess != null)
				{
					onLoginSuccess(msg);
				}
			}

			// 提示登录失败原因
			function $onLoginError(event:XMessageEvent):void
			{
				if (onLoginError != null)
				{
					onLoginError();
				}
			}
		}
	}
}
