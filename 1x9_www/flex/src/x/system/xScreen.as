package x.system
{
    import mx.containers.Canvas;

    import org.amqp.patterns.CorrelatedMessageEvent;

    public class xScreen extends Canvas
    {

        public var entry:xEntry;


        public function xScreen()
        {
        }

        public function init():void
        {

        }

        public function addConsole(console:xConsole):void
        {
            this.addChild(console.input);
        }

        public function show(str:String):void
        {
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
            var result:Object = event.result
            if (result != null)
            {
                trace("renderLine: ");
            }
        }

        public function showError(str:String):void
        {
            show(str);
        }
    }
}