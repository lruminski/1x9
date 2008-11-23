package x.system
{
    import flash.events.Event;

    import mx.controls.TextInput;
    import mx.events.FlexEvent;

    import x.lib.SWFAddress;

    public class xConsole
    {
        public var input:TextInput;
        public var screen:xScreen;

        private var entry_line:xEntryLine;

        public function xConsole(screen:xScreen = null) {

            input = new TextInput()
            this.input = input;

            if (screen != null)
            {
                screen.addConsole(this);
                this.screen = screen;

                var error:xError = xError.getInstance();
                error.setErrorConsole(this);
            }

        }

        public function init():void {
            entry_line = new xEntryLine();

            SWFAddress.onChange = handleAddress;
            input.addEventListener(Event.CHANGE, updateConsole)
            input.addEventListener(FlexEvent.ENTER, executeConsole);
        }

        public function get address():String {
            return input.text;
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

            input.text = address

            updateConsole(new Event(Event.CHANGE));
            executeConsole(new FlexEvent(FlexEvent.ENTER));
        }

        private function updateConsole(event:Event):void {
            if (is_entry())
                entry_line.update_words(input.text);
        }

        private function executeConsole(event:FlexEvent):void
        {
            if (is_entry())
                entry_line.save(screen.renderLine);

            if (is_addr())
            {
                SWFAddress.setValue(input.text);
                var entry:xEntry = new xEntry();
                entry.find({addr: input.text}, screen.render)

            }

            input.text = ""

        }

        public function is_addr():Boolean
        {
            if (address.charAt() == "/") {
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