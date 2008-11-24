package x.system
{
    import flash.display.DisplayObject;

    import mx.containers.Canvas;

    import org.amqp.patterns.CorrelatedMessageEvent;

    public class xScreen extends Canvas
    {

        public var entry:xEntry;

        private var lines:Array;
        private var _lines:Array; // cache

        private var current_line:int;

        public function xScreen()
        {
        }

        public function init():void
        {
            lines = new Array();
            current_line = 1;
        }

        public function addConsole(console:xConsole):void
        {
            this.addChild(console.input);
        }

        public function show(str:String):void
        {
            var line:xEntryLine = new xEntryLine();
            line.obj.val = str;
            lines.push(line);
            current_line++;
            trace("show: " + str);
        }

        public function render(event:CorrelatedMessageEvent):void
        {
            var result:Object = event.result
            if (result != null)
            {
                trace("render: ");
            }
        }

        public function renderLine(event:CorrelatedMessageEvent):void
        {
            var result:Object = event.result;

            var display:DisplayObject;

            if (result != null)
            {
                if (lines[current_line] != null)
                {
                    lines[current_line].moveUp();
                }

                trace("renderLine: ");
                var line:xEntryLine = new xEntryLine();
                line.obj = result.result;
                display = line.render();
                lines.push(line);
                addChildAt(display, -1);
                current_line++;
            }
        }

        public function showError(str:String):void
        {
            show(str);
        }
    }
}