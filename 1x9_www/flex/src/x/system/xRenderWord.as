package x.system
{
	import caurina.transitions.Tweener;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.BlurFilter;
	
	import mx.controls.Text;
	import mx.events.FlexEvent;
	
	public class xRenderWord extends Text
	{
    	public var render_time:Number = 1;    	
    	public var render_delay:Number = 0;

		public function xRenderWord(val:String)
		{
			this.text = val;
            this.alpha = 0;
			this.scaleX = 0;
			this.addEventListener(Event.ADDED, added);
			this.addEventListener(FlexEvent.UPDATE_COMPLETE, created);
			
			var filter:BlurFilter=new BlurFilter(7,7,BitmapFilterQuality.HIGH);  
			var filters_array:Array=new Array();  
			filters_array.push(filter);  
			
			this.filters = filters_array;			
		}
		
		public function update(val:String):void
		{
			this.text = val;
			trace(this.alpha);
		}
		
		private function created(event:FlexEvent):void
		{
		}

        private function added(event:Event):void
        {
        	var target:DisplayObject = event.target as DisplayObject;
        	trace("added " + target + ", delay: " + render_delay + ", alpha: " + alpha);
        	//this.alpha = 0;
			Tweener.addTween(event.target, {alpha:1, time:render_time,scaleX:1, delay:render_delay, transition:"easeInOutQuad"});
			
			Tweener.addTween(event.target, {_Blur_blurX:0, _Blur_blurY:0, time:render_time, delay:render_delay, transition:"easeInQuad"});
        	 
        }

	}
}