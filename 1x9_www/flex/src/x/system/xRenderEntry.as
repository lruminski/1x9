package x.system
{
    import caurina.transitions.Tweener;
    import caurina.transitions.properties.FilterShortcuts;
    
    import flash.display.DisplayObject;
    import flash.events.TimerEvent;
    import flash.utils.Timer;
    
    import mx.containers.VBox;
    import mx.events.ChildExistenceChangedEvent;
    
    import org.amqp.patterns.CorrelatedMessageEvent;
    
    import x.lib.Network;
    
    public class xRenderEntry extends VBox
    {
    	public const RENDER_TIME:Number = 0.333;
    	public const RENDER_TRANSITION:String = "easeOutSine";
    	public const MAX_PAUSE_TIME:Number = 5;
    	
    	public const UPDATE_TIME:uint = 1000;
    	
    	public var time_multiplier:Number = 4;
    	
    	private var timeline:Array;
    	private var timer:Timer;
    	private var _time:uint = 0;
    	
        private var entry:xEntry;
        private var comm:Network;

        private var lines:Array;

        public function xRenderEntry(entry:xEntry = null)
        {
            FilterShortcuts.init();
            
            lines = new Array();
            timeline = new Array();
            timer = new Timer(UPDATE_TIME / time_multiplier);
            timer.addEventListener(TimerEvent.TIMER, renderTime);

            if (entry != null)
            {
	            this.entry = entry;
	            render()
	       	}
            
            comm = Network.getInstance();            
            //comm.subscribe("entry", "test", consumeEntry);
            //comm.subscribe("entry", entry.obj.id, consumeEntry);
            //comm.serv.send("entry", "render", entry.obj.id, doNothing);
            
            this.alpha = 0;
            this.addEventListener(ChildExistenceChangedEvent.CHILD_ADD, added);
        }
        
        public function set time(val:uint):void
        {
        	var i:uint;

            var renderTime:xRenderTimeEvent
            
        	// going forward
        	for (i=_time; i < val; i++)
        	{
        		if (timeline[i])
        		{
        			renderTime = new xRenderTimeEvent(xRenderTimeEvent.RENDER_TIME, i, _time);
        			this.dispatchEvent(renderTime);
        		}
        	}
        	
        	// going backwards
        	for (i=_time; i > val; i--)
        	{
        		if (timeline[i])
        		{
        			renderTime = new xRenderTimeEvent(xRenderTimeEvent.RENDER_TIME, i, _time);
        			this.dispatchEvent(renderTime);
        		}        		
        	}
        	
        	_time = val;
        }
        
        public function get time():uint
        {
        	return _time;
        }
        
        public function render():void
        {
        	trace("xRenderEntry: render()");
            entry.show(renderWords);
        }

        public function addLine(line:DisplayObject):void
        {
            this.addChild(line);
        }

        public function renderWords(event:CorrelatedMessageEvent):void
        {
        	
            var result:Object = event.result;

            var render_line:xRenderLine;
            
        	var i:int;

            if (result != null)
            {

                trace("renderWords: ");
                                
                if (result.result)
                { 
                	
                	var words:Array = result.result;
                	if (words.length > 0)
                		var last_time:Number = words[0].time_elapsed;
                	
                	for (i = 0; i < words.length; i++)
                	{
                		
                		var word:Object = words[i];
                		                		
		                if (last_time - word.time_elapsed > MAX_PAUSE_TIME) 
		                	word.time_elapsed = last_time + MAX_PAUSE_TIME;
		                	
		                last_time = word.time_elapsed;

                		var renderAt:uint = word.time_elapsed; 

                		if (!timeline[renderAt])
                			timeline[renderAt] = true;
                			
                			                		
	                	if (!lines[word.line_num])
	                	{
			                render_line = new xRenderLine(); 
	                	} else {
	                		render_line = lines[word.line_num];
	                	}
	                	
		                render_line.renderWord(word);
                	}
                	 
		            if (!timer.running)
		            	timer.start();
		            	
	           	}
            }
            
        }
        
        private function renderTime(event:TimerEvent):void
        {
        	time+=timer.delay	
        }
        
        private function added(event:ChildExistenceChangedEvent):void
        {
        	var target:DisplayObject = event.target as DisplayObject;
			var delayIndex:Number = 1;
			
			Tweener.addTween(event.target, {alpha:1, time:RENDER_TIME, transition:RENDER_TRANSITION});
        }
        
        private function consumeEntry(event:CorrelatedMessageEvent):void
        {
        	var result:Object = event.result;
        	if (result)
        	{
        		trace("consumeEntry: ");
        		
        	}
        }
        
        private function doNothing(event:CorrelatedMessageEvent):void
        {
            // even nothing is something
        }
    }
}