package ssen.mvc.examples.basic.views {
import ssen.mvc.Evt;
import ssen.mvc.EvtGatherer;
import ssen.mvc.IEventBus;
import ssen.mvc.IMediator;
import ssen.mvc.examples.basic.events.MessageErrorEvent;
import ssen.mvc.examples.basic.events.MessageEvent;

public class LogViewerMediator implements IMediator {
	//==========================================================================================
	// dependent
	//==========================================================================================
	[Inject]
	public var eventBus:IEventBus;

	//==========================================================================================
	// view
	//==========================================================================================
	private var view:LogViewer;

	public function setView(value:Object):void {
		view=value as LogViewer;
	}

	//==========================================================================================
	// initial
	//==========================================================================================
	private var evtGatherer:EvtGatherer;

	public function onRegister():void {
		evtGatherer=new EvtGatherer;
		evtGatherer.add(eventBus.addEventListener(MessageEvent.ADD_MESSAGE, printEvent));
		evtGatherer.add(eventBus.addEventListener(MessageEvent.ADDED_MESSAGE, printEvent));
		evtGatherer.add(eventBus.addEventListener(MessageEvent.REMOVE_MESSAGE, printEvent));
		evtGatherer.add(eventBus.addEventListener(MessageEvent.REMOVED_MESSAGE, printEvent));
		evtGatherer.add(eventBus.addEventListener(MessageEvent.UPDATE_MESSAGE, printEvent));
		evtGatherer.add(eventBus.addEventListener(MessageEvent.UPDATED_MESSAGE, printEvent));
		evtGatherer.add(eventBus.addEventListener(MessageEvent.START_UPDATE, printEvent));
		evtGatherer.add(eventBus.addEventListener(MessageErrorEvent.TEXT_IS_BLANK, printEvent));
		evtGatherer.add(eventBus.addEventListener(MessageErrorEvent.ADD_FAILED, printEvent));
		evtGatherer.add(eventBus.addEventListener(MessageErrorEvent.REMOVE_FAILED, printEvent));
	}

	public function onRemove():void {
		evtGatherer.dispose();
		evtGatherer=null;
		view=null;
		eventBus=null;
	}

	//==========================================================================================
	// evt listeners
	//==========================================================================================
	private function printEvent(event:Evt):void {
		view.appendText(event + "\n");
	}
}
}
