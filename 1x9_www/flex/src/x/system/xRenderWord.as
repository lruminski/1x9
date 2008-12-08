package x.system
{
	import caurina.transitions.Tweener;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	import mx.controls.Text;
	
	import x.system.xFontManager;
	
	public class xRenderWord extends Text
	{
    	public var render_time:Number = 1;    	
    	public var render_delay:Number = 0;

		public function xRenderWord(val:String)
		{
			this.text = val;
            this.addEventListener(Event.ADDED, added);
			alpha = 0;
		}
		
		public function update(val:String):void
		{
			this.text = val;
			trace(this.alpha);
		}

        private function added(event:Event):void
        {
        	this.alpha = 0;
        	var target:DisplayObject = event.target as DisplayObject;
        	trace("added " + target + ", delay: " + render_delay + ", alpha: " + alpha); 
			Tweener.addTween(event.target, {alpha:1, time:render_time, delay:render_delay, transition:"easeOutSine"});
        }

	}
}