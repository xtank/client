package editordata
{
	import flash.geom.Point;
	
	import x.game.util.StringUtil;

	public class MapData
	{
		public var id:uint = 0 ;
		public var name:String = "地图??" ;
		public var difficult:uint = 1 ;
		public var team1:TeamData ;
		public var team2:TeamData ;
		//
		public var bgLayer:String = "Tank_Bg_1" ;
		public var elemLayer:Vector.<ElemeData> ;
		public var lowLayer:Vector.<TerrierData> ;
		public var pathLayer:Vector.<Point> ;
		
		public function MapData()
		{
			team1 = new TeamData(1) ;
			team2 = new TeamData(2) ;
			//
			elemLayer = new Vector.<ElemeData>() ;
			pathLayer = new Vector.<Point>() ;
			lowLayer = new Vector.<TerrierData>() ;
		}
		
		public function addElem(elem:ElemeData):void
		{
			elemLayer.push(elem) ;
		}
		
		public function removeElem(elem:ElemeData):void
		{
			var index:int = elemLayer.indexOf(elem) ;
			if(index != -1)
			{
				elemLayer.splice(index,1) ;
			}
		}
		
		public function get description():String
		{
			var elemContent:Array = [] ;
			for each(var ele:ElemeData in elemLayer)
			{
				elemContent.push(ele.description) ;
			}
			var lowContent:Array = [] ;
			for each(var ele2:TerrierData in lowLayer)
			{
				lowContent.push(ele2.description) ;
			}
			var pathContent:Array = [] ;
			for each(var p:Point in pathLayer)
			{
				pathContent.push(p.x+","+p.y) ;
			}
			var rs:String = '<map id="' + id + '" name="'+name+'" difficult="'+ difficult+'">\n' +
					team1.description + "\n" + 
					team2.description +"\n" + 
					'<bgLayer>' + bgLayer + '</bgLayer>\n' +
					'<lowLayer>' + lowContent.join(";") + '</lowLayer>\n' +
					'<elemLayer>' + elemContent.join(";") + '</elemLayer>\n' +
					'<pathLyaer>' + pathContent.join(";") + '</pathLyaer>\n' +
					'</map>';
			return rs ;
		}
		
		public function parser(xml:XML):MapData
		{
			id = xml.@id ;
			name = xml.@name ;
			difficult = xml.@difficult ;
			//
			bgLayer = (xml.bgLayer[0] as XML).toString() ;
			//
			var ele2s:Array = (xml.lowLayer[0] as XML).toString().split(";") ;
			for each(var ele2:String in ele2s)
			{
				ele2 = StringUtil.removeWhitespace(ele2) ;
				if(!StringUtil.isBlank(ele2))
				{
					var ddd:TerrierData = new TerrierData() ;
					ddd.id = ele2.split("-")[0] ;
					ddd.reg = new Point(String(ele2.split("-")[1]).split(",")[0],String(ele2.split("-")[1]).split(",")[1]) ;
					lowLayer.push(ddd) ;
				}
			}
			//
			var eles:Array = (xml.elemLayer[0] as XML).toString().split(";") ;
			for each(var ele:String in eles)
			{
				ele = StringUtil.removeWhitespace(ele) ;
				if(!StringUtil.isBlank(ele))
				{
					var dd:ElemeData = new ElemeData() ;
					dd.id = ele.split("-")[0] ;
					dd.reg = new Point(String(ele.split("-")[1]).split(",")[0],String(ele.split("-")[1]).split(",")[1]) ;
					elemLayer.push(dd) ;
				}
			}
			//
			var pthContent:Array  = (xml.pathLyaer[0] as XML).toString().split(";") ;
			for each(var p:String in pthContent)
			{
				if(!StringUtil.isBlank(p))
				{
					pathLayer.push(new Point(p.split(',')[0],p.split(',')[1]));
				}
			}
			//
			var teamInfos:XMLList = xml.team;
			for each (var teamInfo:XML in teamInfos)
			{
				var team:TeamData ;
				if(teamInfo.@id == 1)
				{
					team = team1 ;
				}
				else if(teamInfo.@id == 2)
				{
					team = team2 ;
				}
				//
				if(!StringUtil.isBlank(String(teamInfo.@home)))
				{
					team.home = new Point(String(teamInfo.@home).split(",")[0],String(teamInfo.@home).split(",")[1]) ;
				}
				
				var mm:XMLList = teamInfo.member ;
				for each(var m:XML in mm)
				{
					if(!StringUtil.isBlank(String(m.@born)))
					{
						team.addMember(new Point(String(m.@born).split(",")[0],String(m.@born).split(",")[1])) ;
					}
					else
					{
						team.addMember(new Point(0,0)) ;
					}
				}
			}
			return this;
		}
	}
}