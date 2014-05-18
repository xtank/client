package editordata
{
	import flash.display.Sprite;
	import flash.geom.Point;

	public class TeamData
	{
		public var id:uint = 0;
		public var home:Point = new Point(0,0);
		public var members:Vector.<Point> ;
		//
		public var homeRes:Sprite ;
		

		public function TeamData(id:uint)
		{
			this.id = id;
			members = new Vector.<Point>();
			homeRes = new Sprite
		}

		public function get description():String
		{
			var mm:Array = [] ;
			for(var i:uint = 0;i<members.length;i++)
			{
				mm.push("<member id='" + i+"' born='" +members[i].x +"," + members[i].y+"'/>") ;
			}
			return '<team id="' + id + '" home="' + home.x + "," + home.y + '">\n' +
				mm.join("\n") + 
				'</team>';
		}
		
		public function addMember(born:Point):void
		{
			members.push(born) ;
		}

		public function removeMember(born:Point):void
		{
			for(var i:uint = 0;i<members.length;i++)
			{
				if(members[i].x == born.x && members[i].y == born.y) 
				{
					members.splice(i,1) ;break;
				}
			}
		}
	}
}
