package x.system
{
    import flash.events.Event;

    import mx.controls.TextInput;
    import mx.events.FlexEvent;

    import org.amqp.patterns.CorrelatedMessageEvent;

    import x.lib.SWFAddress;

    public class xConsole
    {
        public var input:TextInput;
        public var screen:xScreen;

        public var num_lines:int;

        private var entry:xEntry;
        private var entry_line:xEntryLine;

        // current_line
        private var _current_line:int;
        public function set current_line(val:int):void {
            _current_line = val;
            entry_line.obj.line_num = val;
        }
        public function get current_line():int {
            return _current_line;
        }


        public function xConsole(screen:xScreen = null) {

            input = new TextInput()
            this.input = input;

            if (screen != null)
            {
                this.screen = screen;

                var error:xError = xError.getInstance();
                error.setErrorConsole(this);
            }
        }

        public function init():void {
            entry_line = new xEntryLine();
            current_line = 1;


            screen.addConsole(this);

            SWFAddress.onChange = handleAddress;
            input.addEventListener(Event.CHANGE, updateConsole)
            input.addEventListener(FlexEvent.ENTER, executeConsole);
        }

        public function get address():String {
            return SWFAddress.getValue();
        }

        public function set address(value:String):void
        {
            trace("set: " + value);
            SWFAddress.setValue(value);
        }

        private function handleAddress():void {
            var address:String = SWFAddress.getValue();

            trace("handle: " + address);

            var title:String = '1X9  ' + address; //.replace(/\//g, '');
            SWFAddress.setTitle(title);

            loadEntry()
        }

        private function updateConsole(event:Event):void {
            if (is_entry())
                entry_line.update_words(input.text);
        }

        private function executeConsole(event:FlexEvent):void
        {
            trace("executeConsole: ");
            if (is_entry()) {
                trace("add line entry");
                entry_line.save(screen.renderLine);
                current_line++;
            }

            if (is_addr() && address != input.text)
            {
                trace("load address");
                address = input.text;
                loadEntry();
            }

            input.text = "";

        }

        public function loadEntry():void
        {
            entry = new xEntry();
            entry.find({addr: address}, entryLoaded)
        }

        public function entryLoaded(event:CorrelatedMessageEvent):void
        {
            var result:Object = event.result
            if (result != null)
            {
                entry.obj = result.result;
                entry_line.obj.entry_id = entry.obj.id;
            }
            screen.renderEntry(entry);
        }

        public function is_addr():Boolean
        {
            if (input.text.charAt() == "/") {
                return true;
            } else {
                return false;
            }
        }

        public function is_entry():Boolean
        {
            if (!is_addr()) {
                return true;
            } else {
                return false;
            }
        }
    }
}