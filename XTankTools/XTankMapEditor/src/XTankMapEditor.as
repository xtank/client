package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.FileReference;
	import flash.text.TextField;
	
	import events.BarrierEvent;
	import events.TerrianEvent;
	
	import views.BarrierView;
	import views.MapView;
	import views.TeamView;
	import views.TerrianView;
	
	import x.game.ui.button.IButton;
	import x.game.ui.button.XSimpleButton;
	
	// 地图编辑器
	[SWF(width = "1260", height = "760", frameRate = 30, backgroundColor = 0xFFFFFF)]
	public class XTankMapEditor extends Sprite
	{
		private var _init:Init ;
		private var _mapView:MapView ;
		private var _barrierView:BarrierView ; // 障碍物
		private var _teamView:TeamView ; //terrianList
		private var _terrianView:TerrianView ;
		private var _skin:Sprite ;
		//
		private var _mapIdTxt:TextField ;
		private var _editButton:XSimpleButton ;
		private var _saveButton:XSimpleButton ;
		//
		
		public function XTankMapEditor()
		{
			_init = new Init(stage,
				function():void
				{
					_skin = new XTankMapEditorUI() ;
					addChild(_skin) ;
					_mapView = new MapView(_skin) ;
					//
					_barrierView = new BarrierView(_skin["barrierList"]) ;
					_barrierView.addEventListener(BarrierEvent.UU,onBUU) ;
					//
					_terrianView = new TerrianView(_skin["terrianList"]) ;
					_terrianView.addEventListener(TerrianEvent.UU,onTUU) ;
					//
					_teamView = new TeamView(_skin,_mapView) ;
					//
					_saveButton = new XSimpleButton(_skin["saveButton"]);
					_saveButton.addClick(onSave) ;
					//
					_editButton = new XSimpleButton(_skin["editButton"]);
					_editButton.addClick(onEdit) ;
					//
					_mapIdTxt = _skin["mapIdTxt"] ;
					_mapIdTxt.text = "1" ;
					_mapIdTxt.restrict = "0-9" ;
					//
					onEdit(null) ;
				}) ;
			//
		}
		
		private function onTUU(event:TerrianEvent):void
		{
			_mapView.tBox.addTerrian(event) ;
		}
		
		private function onBUU(event:BarrierEvent):void
		{
			_mapView.bBox.addBarrier(event) ;
		}
		
		private function onEdit(btn:IButton):void
		{
			var mapId:uint = uint(_mapIdTxt.text) ;
			if(DataManager.getMapData(mapId) != null)
			{
				_mapView.updateMapId(mapId) ;
				_teamView.updateMapId(mapId) ;
			}
		}
		
		private var fileRef:FileReference ;
		
		private function onSave(btn:IButton):void
		{
//			trace(DataManager.parserContent()) ;
			fileRef = new FileReference();
			fileRef.addEventListener(Event.SELECT, onSaveFileSelected);
			fileRef.save(DataManager.parserContent(),"map.xml");
		}
		
		private function onSaveFileSelected(evt:Event):void
		{
			fileRef.addEventListener(ProgressEvent.PROGRESS, onSaveProgress);
			fileRef.addEventListener(Event.COMPLETE, onSaveComplete);
			fileRef.addEventListener(Event.CANCEL, onSaveCancel);
		}
		
		private function onSaveProgress(evt:ProgressEvent):void
		{
			trace("Saved " + evt.bytesLoaded + " of " + evt.bytesTotal + " bytes.");
		}
		
		private function onSaveComplete(evt:Event):void
		{
			//保存动作结束后，删除相关侦听，以减轻服务器的负荷
			trace("File saved.");
			fileRef.removeEventListener(Event.SELECT, onSaveFileSelected);
			fileRef.removeEventListener(ProgressEvent.PROGRESS, onSaveProgress);
			fileRef.removeEventListener(Event.COMPLETE, onSaveComplete);
			fileRef.removeEventListener(Event.CANCEL, onSaveCancel);
		}
		//以下为信息提示
		private function onSaveCancel(evt:Event):void
		{
			trace("The save request was canceled by the user.");
		}
		
		private function onIOError(evt:IOErrorEvent):void
		{
			trace("There was an IO Error.");
		}
		
		private function onSecurityError(evt:Event):void
		{
			trace("There was a security error.");
		}
	}
}