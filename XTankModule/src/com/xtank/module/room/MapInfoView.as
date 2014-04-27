package com.xtank.module.room
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.text.TextField;

	import onlineproto.room_data_t;

	import x.game.ui.XComponent;
	import x.game.util.DisplayObjectUtil;
	import x.tank.core.cfg.DataProxyManager;
	import x.tank.core.cfg.model.MapConfigInfo;

	public class MapInfoView extends XComponent
	{
		private var _roomNameTxt:TextField;
		private var _mapNameTxt:TextField;
		private var _mapDifficultStar:MovieClip;
		private var _teamLimit:MovieClip;
		private var _playerLimit:MovieClip;

		public function MapInfoView(skin:DisplayObject)
		{
			super(skin);
			_roomNameTxt = skin["roomNameTxt"];
			DisplayObjectUtil.disableTarget(_roomNameTxt);
			_mapNameTxt = skin["mapNameTxt"];
			DisplayObjectUtil.disableTarget(_mapNameTxt);
			_mapDifficultStar = skin["mapDifficultStar"];
			_mapDifficultStar.gotoAndStop(1);
			DisplayObjectUtil.disableTarget(_mapDifficultStar);
			_teamLimit = skin["teamLimit"];
			DisplayObjectUtil.disableTarget(_teamLimit);
			_playerLimit = skin["playerLimit"];
			DisplayObjectUtil.disableTarget(_playerLimit);
		}

		override public function dispose():void
		{
			super.dispose();
		}

		override public function set data(value:Object):void
		{
			super.data = value;
			updateView();
		}

		private function updateView():void
		{
			if (data != null)
			{
				var roomData:room_data_t = data as room_data_t;
				var mapId:uint = roomData.mapid;
				var configInfo:MapConfigInfo = DataProxyManager.mapData.getMapInfo(mapId);
				_mapNameTxt.text = configInfo.name;
				_mapDifficultStar.gotoAndStop(configInfo.difficult);
				_teamLimit.gotoAndStop(configInfo.teamLimitCount + 1);
				_playerLimit.gotoAndStop(configInfo.playerLimitCount + 1);
				//
				_roomNameTxt.text = roomData.name ;
			}
		}
	}
}
