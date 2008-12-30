package x.system
{
	import flash.events.MouseEvent;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.DropShadowFilter;
	
	import mx.containers.VBox;

    public class xRenderLine extends VBox
    {
    	public var render_time:Number = 0.333;    	
    	public var render_delay:Number = 0;

    	private var entry_line:xEntryLine;
    	private var render_entry:xRenderEntry;
    	private var words:Array;

    	private var timeline:Array;
    	private var _time:uint = 0;
    	
        public function xRenderLine()
        {
        	this.addEventListener(MouseEvent.MOUSE_OVER, showProperties);
        	this.addEventListener(xRenderTimeEvent.RENDER_TIME, renderTime);
        	
        }
        
        public function renderWord(word:Object):void
        {
        	var renderAt:Number = word.time_elapsed;
        	if (!timeline[renderAt])
        	{
        		timeline[renderAt] = new Array();
        		timeline[renderAt].push(word);
        	}
        }
    	
        private function renderTime(event:xRenderTimeEvent):void
        {
        	
        } 
        

    	/*
        public function xRenderLine(render_entry:xRenderEntry)
        {
        	this.render_entry = render_entry;
        }
		*/
        public function render(entry_line:xEntryLine):void
        {
        	
        	var i:int;
        	var word:xRenderWord;
        	
			var line_str:String = entry_line.obj.val; 
			
			var words:Array = line_str.split(" ");
			
			for (i = 0; i < this.numChildren; i++)
			{
				word = this.getChildAt(i) as xRenderWord;
				if (word.val != words[i])
					word.update(words[i], render_delay)
			}
			
			for (i = this.numChildren; i < words.length; i++)
			{
				word = new xRenderWord(words[i]);
				word.render_delay = render_delay;
				trace("renderDelay: " + word.render_delay);
				addChild(word);				
			} 
			
			var dropShadow:DropShadowFilter = new DropShadowFilter();
			dropShadow.color = 0x000000;
			dropShadow.blurX = 7;
			dropShadow.blurY = 7;
			dropShadow.angle = 45;
			dropShadow.alpha = 0.5;
			dropShadow.quality = BitmapFilterQuality.HIGH;
			dropShadow.distance = 3;
			
            this.filters = [dropShadow];
			
			/*
            this.entry_line = entry_line;
            var words_str:String = entry_line.obj.val;
            
            var words:Array = words_str.split(" ");
            for (var word:String in words) {
            	
            }
			*/
            //this.text = entry_line.obj.val;
        }

        public function moveUp():void
        {

        }
        
        private function showProperties(event:MouseEvent):void
        {
        	
        }
    }
}