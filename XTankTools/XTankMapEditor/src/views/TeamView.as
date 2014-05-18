package views
{
	import flash.display.DisplayObject;
	import flash.geom.Point;
	import flash.text.TextField;
	
	import editordata.MapData;
	import editordata.TeamData;
	
	import x.game.ui.XComponent;
	import x.game.ui.button.IButton;
	import x.game.ui.button.XButton;
	import x.game.ui.button.XSimpleButton;
	import x.game.ui.buttonbar.XButtonBar;

	public class TeamView extends XComponent
	{
		private var _mapView:MapView;
		//
		private var _bar:XButtonBar;
		private var _addBtn:XSimpleButton ;
		private var _mapData:MapData;
		private var _teamTxt:TextField ;
		private var _homeXTxt:TextField ;
		private var _homeYTxt:TextField ;
		//
		private var _currentTeam:TeamData ;

		public function TeamView(skin:DisplayObject,mapView:MapView)
		{
			super(skin);
			_mapView = mapView ;
			//
			_homeXTxt = skin["homeXTxt"] ;
			_homeYTxt = skin["homeYTxt"] ;
			_teamTxt = skin["teamTxt"] ;
			//
			_bar = new XButtonBar(skin["teamBar"]);
			_bar.addButton(new XButton(_bar.skin['btn1'], 1), true);
			_bar.addButton(new XButton(_bar.skin['btn2'], 2));
			_bar.addChange(function(bar:XButtonBar):void
			{
				var d:uint = uint(bar.selectedButton.data);
				if(_mapData)
				{
					switch (d)
					{
						case 1:
							updateCurrentTeam(_mapData.team1) ;
							break;
						case 2:
							updateCurrentTeam(_mapData.team2) ;
							break;
					}
				}
			});
			//
			_addBtn = new XSimpleButton(skin["addButton"]) ;
			_addBtn.addClick(onAddMember) ;
		}
		
		public function updateCurrentTeam(teamInfo:TeamData):void
		{
			_currentTeam = teamInfo ;
			_homeXTxt.text = "" + _currentTeam.home.x ;
			_homeYTxt.text = "" + _currentTeam.home.y ;
			_teamTxt.text = "队伍:" + _currentTeam.id ; 
		}
		
		private function onAddMember(btn:IButton):void
		{
			if(_currentTeam)
			{
				_currentTeam.addMember(new Point(0,0));
			}
		}

		public function updateMapId(mapId:uint):void
		{
			_mapData = DataManager.getMapData(mapId);
			_bar.setDefaultSelectedButton(0) ;
		}

		public function get mapData():MapData
		{
			return _mapData;
		}
	}
}
