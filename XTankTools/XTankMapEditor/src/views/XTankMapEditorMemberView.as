package views
{
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.text.TextField;
	
	import editordata.TeamData;
	
	import x.game.ui.XComponent;
	import x.game.ui.button.IButton;
	import x.game.ui.button.XSimpleButton;
	
	public class XTankMapEditorMemberView extends XComponent
	{
		private var _xTxt:TextField ;
		private var _yTxt:TextField ;
		private var _delButton:XSimpleButton ;
		//
		private var _point:Point ;
//		private var _currentTeam:TeamData ;
		private var _ref:Function ;
		
		public function XTankMapEditorMemberView(ref:Function)
		{
			super(new XTankMapEditorMemberUI());
//			_currentTeam = currentTeam ;
			_ref = ref ;
			_xTxt = _skin["homeXTxt"] ;
			_yTxt = _skin["homeYTxt"] ;
			_xTxt.restrict = "0-9"
			_yTxt.restrict = "0-9"
			//
			_delButton = new XSimpleButton(_skin["delButton"]) ;
			_delButton.addClick(onDelButton) ;
		}
		
		public function get point():Point{return _point;}
		
		public function get skin():Sprite{return _skin as Sprite ;}
		
		public function updateMember(p:Point):void
		{
			_point = p ;
			//
			_xTxt.text = _point.x + "" ;
			_yTxt.text = _point.y + "" ;
		}
		
		private function onDelButton(btn:IButton):void
		{
			_ref(this) ;
		}
	}
}