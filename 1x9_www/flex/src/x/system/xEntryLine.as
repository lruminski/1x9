package x.system
{
    import flash.display.DisplayObject;


    public class xEntryLine extends xEntry
    {

        public var renderObj:xRenderLine;
        private var entry:xEntry;

        public function xEntryLine(num:int = 0, id:int = -1, val:String = "", entry:xEntry = null, type:String = "entry_lines")
        {
            if (entry == null)
            {
                entry = new xEntry();
            }
            this.entry = entry;
            super(entry.id, type);

            obj.line_num = num;
            obj.val = val;
            
            //words = new Array("");
        }

        public function update_words(entry_str:String):void
        {
        	if (obj == null)
        	{
        		obj = new Object;
        	}
        	
            if (obj.val != entry_str)
            {
                obj.val = entry_str;
                trace("update_words: " + obj.id + " " + obj.val);
                update(saveResult);
            }
        }
        
        public function update_word(val:String, pos:int):void
        {
        	var words:Array = (this.obj.val as String).split(" ");
        	words[pos] = val;
        	this.obj.val = words.join(" ");
        }

		
        public function render():DisplayObject
        {
            if (renderObj == null)
            {
                renderObj = new xRenderLine();
				/*
	               screenObj = new xRenderLine(entry);
               */
            }

            renderObj.render(this);

            return renderObj;
        }
    }
}