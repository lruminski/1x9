// initialize (this file will be eventually generated by the server)

import mx.events.FlexEvent;

import x.system.xConsole;
import x.system.xNetwork;
import x.system.xScreen;
import x.system.xError;

public var xscreen:xScreen;
public var xconsole:xConsole;
public var xnetwork:xNetwork;

public function xInit(event:FlexEvent):void
{

    xscreen = new xScreen();
    xconsole = new xConsole(xscreen);
    xnetwork = new xNetwork(Application.application.parameters.session_id);

    addChild(xscreen);

}