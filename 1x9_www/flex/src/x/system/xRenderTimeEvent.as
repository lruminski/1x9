package x.system
{
	import flash.events.Event;

	public class xRenderTimeEvent extends Event
	{
		public static const RENDER_TIME:String = "render_time";
		
		public var time:Number;
		public var last_time:Number;
		
		public function xRenderTimeEvent(type:String, time:Number, last_time:Number, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			this.time = time;
			this.last_time = last_time;
			super(type, bubbles, cancelable);
		}
		
	}
}