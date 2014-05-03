package x.game.net.post
{
    import com.netease.protobuf.Message;
    
    import x.game.log.core.Logger;
    import x.game.manager.SurfaceManager;
    import x.game.net.response.XMessageEvent;

    /**
     * 支持回调类发送消息
     * @author fraser
     */
    public class CallbackPost extends SimpleCallbackPost
    {
        public function CallbackPost(cmdId:uint, msg:Message = null, onComplete:Function = null, onError:Function = null)
        {
            super(cmdId, msg, onComplete, onError);
        }

        override protected function _onErrorHandler(event:XMessageEvent):void
        {
			if(_disposed)
				return ;
			if ((SimpleCallbackPost.FILTER_CMDS.indexOf(_message.cmdId) == -1) && _message.stamp != 0 && _message.stamp != event.response.stamp)
			{
				return;
			}
            if (_onError != null)
            {
                _onError(event);
            }
            // 默认处理为弹出提示
			SurfaceManager.addTextSurface("" + event.response.statusCode);
			//
            dispose();
        }
    }
}
