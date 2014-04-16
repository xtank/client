package x.tank.app.scene.lobby.view
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.text.TextField;
	
	import x.game.ui.XComponent;
	import x.game.ui.digital.DigitalNumber;
	import x.game.util.DisplayObjectUtil;
	import x.tank.core.cfg.DataProxyManager;
	import x.tank.core.cfg.handler.MapDataHandler;
	import x.tank.core.cfg.model.MapConfigInfo;
	import x.tank.core.model.Room;

	public class LobbyRoomView extends XComponent
	{
		private var _nameTxt:TextField;
		private var _countTxt:TextField;
		private var _tag:MovieClip; // 1 等待中  2.游戏中
		private var _lockFlag:MovieClip;
		private var _digitals:DigitalNumber ;

		public function LobbyRoomView(skin:DisplayObject)
		{
			super(skin);
			_nameTxt = _skin["nameTxt"];
			_countTxt = _skin["countTxt"];
			_tag = _skin["tag"];
			_lockFlag = _skin["lockFlag"];
			//
			DisplayObjectUtil.disableTarget(_nameTxt);
			DisplayObjectUtil.disableTarget(_countTxt);
			DisplayObjectUtil.disableTarget(_tag);
			DisplayObjectUtil.disableTarget(_lockFlag);
			//
			var digitals:Vector.<MovieClip> = new Vector.<MovieClip>() ;
			digitals.push(_skin["qianwei"]) ;
			digitals.push(_skin["baiwei"]) ;
			digitals.push(_skin["shiwei"]) ;
			digitals.push(_skin["gewei"]) ;
			_digitals = new DigitalNumber(_skin,digitals) ;
		}

		override public function set data(value:Object):void
		{
			super.data = value;
			//
			if (_data == null)
			{
				_nameTxt.text = "";
				_countTxt.text = "";
				_tag.gotoAndStop(1);
				_lockFlag.gotoAndStop(1);
				_digitals.updateValue(0) ;
				//
				_skin.visible = false;
			}
			else
			{
				var roomData:Room = _data as Room;
				//
				var handler:MapDataHandler = DataProxyManager.mapData ;
				var mapCfg:MapConfigInfo = handler.getMapInfo(roomData.mapid) ;
				//
				_nameTxt.text = roomData.name ;
				_countTxt.text = roomData.currentCount + "/" + mapCfg.playerLimitCount;
				_tag.gotoAndStop(roomData.status + 1);
				_lockFlag.gotoAndStop(roomData.passwd == 0 ? 1 : 2);
				_digitals.updateValue(roomData.id) ;
				
				_skin.visible = true;
			}
		}
	}
}
