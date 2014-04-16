package x.tank.app.scene.lobby.view
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.text.TextField;
	
	import x.game.ui.XComponent;
	import x.game.ui.digital.DigitalNumber;
	import x.game.util.DisplayObjectUtil;
	import x.tank.app.cfg.TankConfig;
	import x.tank.core.event.PlayerEvent;
	import x.tank.core.manager.PlayerManager;
	import x.tank.core.model.Player;
	
	public class UserInfoView extends XComponent
	{
		private var _nameTxt:TextField ;
		private var _rank:DigitalNumber ;
		
		public function UserInfoView(skin:DisplayObject)
		{
			super(skin);
			_nameTxt = skin["nameTxt"] ;
			DisplayObjectUtil.disableTarget(_nameTxt) ;
			_rank = new DigitalNumber(skin,Vector.<MovieClip>([skin["qianwei"],skin["baiwei"],skin["shiwei"],skin["gewei"]])) ;
			//
			PlayerManager.addEventListener(PlayerEvent.PLAYER_UPDATE,onPlayerUpdate) ;
		}
		
		override public function dispose():void
		{
			_rank.dispose() ;
			_rank = null ;
			super.dispose() ;
		}
		
		private function onPlayerUpdate(event:PlayerEvent):void
		{
			if(event.player.id == TankConfig.userId)
			{
				updateInfo(event.player) ;
			}
		}
		
		public function updateInfo(player:Player):void
		{
			_nameTxt.text = player.name ;
			_rank.updateValue(99) ;
		}
	}
}