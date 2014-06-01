package views
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.text.TextField;
	
	import editordata.MapData;
	import editordata.TeamData;
	
	import x.game.ui.XComponent;
	import x.game.ui.button.IButton;
	import x.game.ui.button.XButton;
	import x.game.ui.button.XSimpleButton;
	import x.game.ui.buttonbar.XButtonBar;
	import x.game.util.DisplayObjectUtil;

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
		private var _members:Vector.<XTankMapEditorMemberView> ;
		private var _memberList:MovieClip ;
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
			_memberList = skin["memberList"];
			_members = new Vector.<XTankMapEditorMemberView>() ;
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
		
		public function clear():void
		{
			while(_members.length > 0)
			{
				_members.pop().dispose() ;
			}
		}
		
		public function updateCurrentTeam(teamInfo:TeamData):void
		{
			//
			clear() ;
			//
			_currentTeam = teamInfo ;
			_homeXTxt.text = "" + _currentTeam.home.x ;
			_homeYTxt.text = "" + _currentTeam.home.y ;
			_teamTxt.text = "队伍:" + _currentTeam.id ; 
			//
			var len:uint = _currentTeam.members.length ;
			var view:XTankMapEditorMemberView ;
			for(var i:uint = 0;i<len;i++)
			{
				view = new XTankMapEditorMemberView(onRemoveMember) ;
				view.updateMember(_currentTeam.members[i]) ;
				_members.push(view) ;
			}
			layoutMembers() ;
		}
		
		private function layoutMembers():void
		{
			DisplayObjectUtil.removeAllChildren(_memberList) ;
			//v
			var startx:uint = 2 ;
			var len:uint = _members.length ;
			for(var i:uint = 0;i<len;i++)
			{
				_members[i].y = startx ;
				_memberList.addChild(_members[i].skin) ;
				startx += (_members[i].height + 2) ;
			}
		}
		
		private function onRemoveMember(view:XTankMapEditorMemberView):void
		{
			_currentTeam.removeMember(view.point) ;
			_members.splice(_members.indexOf(view),1) ;
			layoutMembers() ;
		}
		
		private function onAddMember(btn:IButton):void
		{
			if(_currentTeam)
			{
				var p:Point = new Point(0,0) ;
				_currentTeam.addMember(p);
				//
				var view:XTankMapEditorMemberView = new XTankMapEditorMemberView(onRemoveMember) ;
				view.updateMember(p) ;
				_members.push(view) ;
			}
			layoutMembers() ;
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
