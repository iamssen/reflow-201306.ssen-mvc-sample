package ssen.mvc.examples.basic.views {
import mx.managers.PopUpManager;

import ssen.common.IAsyncUnit;
import ssen.mvc.EvtGatherer;
import ssen.mvc.IEventBus;
import ssen.mvc.IMediator;
import ssen.mvc.examples.basic.events.MessageErrorEvent;
import ssen.mvc.examples.basic.events.MessageEvent;
import ssen.mvc.examples.basic.models.Message;
import ssen.mvc.examples.basic.services.IMessageService;

public class MessageUpdateMediator implements IMediator {
	//==========================================================================================
	// inject dependent
	//==========================================================================================
	[Inject]
	public var eventBus:IEventBus;

	[Inject]
	public var service:IMessageService;

	//==========================================================================================
	// inject view
	//==========================================================================================
	private var view:MessageUpdate;

	public function setView(value:Object):void {
		view=value as MessageUpdate;
		view.submit=submit;
		view.close=close;
	}

	//==========================================================================================
	// life cycle
	//==========================================================================================
	private var evtGatherer:EvtGatherer;

	public function onRegister():void {
		view.enabled=false;

		evtGatherer=new EvtGatherer;
		evtGatherer.add(eventBus.addEventListener(MessageEvent.UPDATED_MESSAGE, updatedMessage));
		evtGatherer.add(eventBus.addEventListener(MessageErrorEvent.UPDATE_FAILED, updateFailed));

		// init message
		var unit:IAsyncUnit=service.getMessage(view.targetMessageId);
		unit.result=function(message:Message):void {
			view.enabled=true;

			view.textInput.text=message.text;
			view.focusManager.setFocus(view.textInput);
			view.textInput.selectRange(view.textInput.text.length, view.textInput.text.length);
		};

		unit.fault=function(error:Error):void {
			trace("MessageUpdateMediator.enclosing_method", error);
		};
	}

	public function onRemove():void {
		evtGatherer.dispose();
		view.submit=null;
		view.close=null;

		evtGatherer=null;
		eventBus=null;
		service=null;
		view=null;
	}

	//==========================================================================================
	// wired methods
	//==========================================================================================
	public function submit():void {
		var str:String=view.textInput.text;

		if (str === "") {
			eventBus.dispatchEvent(new MessageErrorEvent(MessageErrorEvent.TEXT_IS_BLANK));
			return;
		}

		view.enabled=false;

		var evt:MessageEvent=new MessageEvent(MessageEvent.UPDATE_MESSAGE);
		evt.messageId=view.targetMessageId;
		evt.text=str;

		eventBus.dispatchEvent(evt);
	}

	public function close():void {
		PopUpManager.removePopUp(view);
	}

	//==========================================================================================
	// evt listeners
	//==========================================================================================
	private function updateFailed(event:MessageErrorEvent):void {
		trace("MessageUpdateMediator.updateFailed", event);
	}

	private function updatedMessage(event:MessageEvent):void {
		trace("MessageUpdateMediator.updatedMessage", event);
		view.close();
	}
}
}
