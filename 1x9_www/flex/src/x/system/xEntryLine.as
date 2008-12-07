package x.system
{
    import flash.display.DisplayObject;


    public class xEntryLine extends xEntry
    {

<<<<<<< HEAD:1x9_www/flex/src/x/system/xEntryLine.as
        public var renderObj:xRenderLine;
=======
        public var screenObj:xRenderLine;
        private var entry:xEntry;
>>>>>>> d48e805d3c2fc3ae44eff31bd83661076ecb0b8e:1x9_www/flex/src/x/system/xEntryLine.as

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

		/*
        public function render():DisplayObject
        {
            if (renderObj == null)
            {
<<<<<<< HEAD:1x9_www/flex/src/x/system/xEntryLine.as
                renderObj = new xRenderLine();
=======
                screenObj = new xRenderLine(entry);
>>>>>>> d48e805d3c2fc3ae44eff31bd83661076ecb0b8e:1x9_www/flex/src/x/system/xEntryLine.as
            }

            renderObj.render(this);

            return renderObj;
        }
        */

    }
}