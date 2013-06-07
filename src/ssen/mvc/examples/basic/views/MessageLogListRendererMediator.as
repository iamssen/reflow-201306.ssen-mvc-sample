package ssen.mvc.examples.basic.views {
import ssen.mvc.IEventBus;
import ssen.mvc.IMediator;
import ssen.mvc.examples.basic.events.MessageEvent;

public class MessageLogListRendererMediator implements IMediator {
	//==========================================================================================
	// inject dependent
	//==========================================================================================
	[Inject]
	public var eventBus:IEventBus;

	//==========================================================================================
	// inject view
	//==========================================================================================
	private var view:MessageLogListRenderer;

	public function setView(value:Object):void {
		view=value as MessageLogListRenderer;
		view.update=update;
		view.remove=remove;
	}

	public function onRegister():void {
	}

	public function onRemove():void {
		view.update=null;
		view.remove=null;
		view=null;
	}

	//==========================================================================================
	// wired methods
	//==========================================================================================
	private function update():void {
		var evt:MessageEvent=new MessageEvent(MessageEvent.START_UPDATE);
		evt.messageId=view.getId();

		eventBus.dispatchEvent(evt);
	}

	private function remove():void {
		var evt:MessageEvent=new MessageEvent(MessageEvent.REMOVE_MESSAGE);
		evt.messageId=view.getId();

		eventBus.dispatchEvent(evt);

		view.enabled=false;
	}
}
}
