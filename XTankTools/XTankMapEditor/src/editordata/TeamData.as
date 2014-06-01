package editordata
{
	import flash.geom.Point;

	public class TeamData
	{
		public var id:uint = 0;
		public var home:Point = new Point(0,0);
		public var members:Vector.<Point> ;
		//
		public var homeResId:uint = 1 ;
		

		public function TeamData(id:uint)
		{
			this.id = id;
			members = new Vector.<Point>();
		}

		public function get description():String
		{
			var mm:Array = [] ;
			for(var i:uint = 0;i<members.length;i++)
			{
				mm.push("<member id='" + i+"' born='" +members[i].x +"," + members[i].y+"'/>") ;
			} // 1-0,0
			return '<team id="' + id + '" home="' + homeResId + "-" + home.x + "," + home.y + '">\n' +
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
