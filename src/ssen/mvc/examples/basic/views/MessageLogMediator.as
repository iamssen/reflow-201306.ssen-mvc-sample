package ssen.mvc.examples.basic.views {
import ssen.mvc.EvtGatherer;
import ssen.mvc.IEventBus;
import ssen.mvc.IMediator;
import ssen.mvc.examples.basic.events.MessageEvent;
import ssen.mvc.examples.basic.models.MessageModel;
import ssen.mvc.examples.basic.services.IMessageService;

public class MessageLogMediator implements IMediator {
	//==========================================================================================
	// inject dependent
	//==========================================================================================
	[Inject]
	public var eventBus:IEventBus;

	[Inject]
	public var service:IMessageService;

	[Inject]
	public var model:MessageModel;

	//==========================================================================================
	// inject view
	//==========================================================================================
	private var view:MessageLog;

	public function setView(value:Object):void {
		view=value as MessageLog;
	}

	//==========================================================================================
	// life cycle
	//==========================================================================================
	private var evtGatherer:EvtGatherer;

	public function onRegister():void {
		view.model=model;

		evtGatherer=new EvtGatherer;
		evtGatherer.add(eventBus.addEventListener(MessageEvent.ADDED_MESSAGE, moveScroll));
	}

	public function onRemove():void {
		evtGatherer.dispose();
		view.model=null;

		evtGatherer=null;
		eventBus=null;
		service=null;
		view=null;
		model=null;
	}

	private function moveScroll(event:MessageEvent):void {
		view.callLater(function():void {
			view.list.verticalScrollPosition=view.list.contentHeight;
		});
	}
}
}
