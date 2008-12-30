package x.system
{
	import caurina.transitions.Tweener;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.BlurFilter;
	import flash.utils.Timer;
	
	import mx.containers.HBox;
	import mx.events.FlexEvent;
	
	public class xRenderWord extends HBox
	{
    	public var render_time:Number = 1;    	
    	public var render_delay:Number = 0;
    	
    	private var _text:String = "";
    	private var timeline:Array;
    	private var timer:Timer;
    	private var letter_timer:Timer;
    	private var _time:uint = 0;
    	//private var direction:int;
    	
		public function xRenderWord(val:String)
		{
			this.text = val;
            //this.alpha = 0;
			this.z = -1000;
			this.addEventListener(Event.ADDED, added);
			this.addEventListener(FlexEvent.UPDATE_COMPLETE, created);

            timeline = new Array();
            timer = new Timer(1000);
            timer.addEventListener(TimerEvent.TIMER, renderTime);
			
			var filter:BlurFilter=new BlurFilter(7,7,BitmapFilterQuality.HIGH);  
			var filters_array:Array=new Array();  
			filters_array.push(filter);  
			
			this.filters = filters_array;			
		}
		
        public function set time(val:uint):void
        {
        	var i:uint;
        	var j:uint;

            var displayObj:DisplayObject;
            var entry_line:xEntryLine;
        	// going forward
        	for (i=_time; i < val; i++)
        	{
        		if (timeline[i])
        			this.val = timeline[i]; 
        	}
        	
        	// going backwards
        	for (i=_time; i > val; i--)
        	{
        		
        	}
        	
        	_time = val;
        }
        
        public function get time():uint
        {
        	return _time;
        }

    	public function get val():String
    	{
    		return _text;
    	}
    	
    	public function set val(val:String):void
    	{
			var delta:int =  val.length - text.length;
			
			/***
			 * delta is not calculated properly
			 * 
			 ***/
			trace("delta: " + val + " :: " + this.text +  " delta: " + delta + " :: " + text.indexOf(val));
			if (delta > 0) {
				direction = 1;
			} else {
				direction = 0;
			}
			delta = Math.abs(delta);
			//if (delta > 0) 
			//{
	    		_text = val;
				letter_timer = new Timer(1000*render_time/delta, delta);
				letter_timer.addEventListener(TimerEvent.TIMER, updateLetters);
				letter_timer.start();
			//}
    	}

		public function update(val:String, render_delay:uint):void
		{
			//this.alpha = 0;
			//this.text = val;
			//this.render_delay = render_delay;
			
			//this.val = val;
			
			if (val == text || (timeline.length != 0 && timeline.lastIndexOf(val) == (timeline.length-1)))
				return;
				
    		if (!timeline[render_delay])
    			timeline[render_delay] = val;
    			
    		if (!timer.running)
    			timer.start();
    			
    		//timeline[renderAt].push(word);
			
			//Tweener.addTween(this, {text:val, alpha:1, time:render_time,scaleX:1, delay:render_delay, transition:"easeInOutQuad"});
			trace("update " + val + " delay: " + render_delay + " :: " + text + " length: " + timeline.length);
		}

        private function renderTime(event:TimerEvent):void
        {
        	time += ( timer.delay/1000 )	
        	trace("time: " + time);
        }
		
		private function updateLetters(event:TimerEvent):void
		{
			if (val != text)
			{
				
				if (val.length > text.length)
				{
					text += val.charAt(text.length);
				}
				else if (text.length > val.length)
				{
					text = text.substr(0, text.length-2);
				}
				/*
				if (direction == 1)
				{
					trace(this + " :"+direction+": " + letter_timer.currentCount + "/" + letter_timer.repeatCount + " " +val + " "  + text);
					this.text = _text.substr(-letter_timer.repeatCount, letter_timer.currentCount);
				} else {				
					trace(this + " :"+direction+": " + letter_timer.currentCount + "/" + letter_timer.repeatCount + " " +val + " "  + text);
					this.text = _text.substr(-letter_timer.repeatCount, letter_timer.currentCount);
				} 
				*/
			}			
			//timer.currentCount
			//event.
		}
		
		private function created(event:FlexEvent):void
		{
		}

        private function added(event:Event):void
        {
        	var target:DisplayObject = event.target as DisplayObject;
        	trace("added " + text + "::"  + target + " delay: " + render_delay + ", alpha: " + alpha);
        	//this.alpha = 0;
			Tweener.addTween(event.target, {alpha:1, time:render_time,scaleX:1, delay:render_delay, transition:"easeInOutQuad"});
			
			Tweener.addTween(event.target, {_Blur_blurX:0, _Blur_blurY:0, time:render_time, delay:render_delay, transition:"easeInQuad"});
        	 
        }

	}
}