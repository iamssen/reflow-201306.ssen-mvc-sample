package ssen.mvc.examples.basic.views {
import mx.collections.ArrayList;
import mx.collections.IList;

import ssen.mvc.EvtGatherer;
import ssen.mvc.IEventBus;
import ssen.mvc.IMediator;
import ssen.mvc.examples.basic.events.MessageEvent;
import ssen.mvc.examples.basic.models.Message;
import ssen.mvc.examples.basic.services.IMessageService;

public class MessageLogMediator implements IMediator {
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
	private var view:MessageLog;

	public function setView(value:Object):void {
		view=value as MessageLog;
		view.dataProvider=new ArrayList;
	}

	//==========================================================================================
	// life cycle
	//==========================================================================================
	private var evtGatherer:EvtGatherer;

	public function onRegister():void {
		evtGatherer=new EvtGatherer;
		evtGatherer.add(eventBus.addEventListener(MessageEvent.ADDED_MESSAGE, addedMessage));
		evtGatherer.add(eventBus.addEventListener(MessageEvent.UPDATED_MESSAGE, updatedMessage));
		evtGatherer.add(eventBus.addEventListener(MessageEvent.REMOVED_MESSAGE, removedMessage));
	}

	public function onRemove():void {
		evtGatherer.dispose();
		view.dataProvider=null;

		eventBus=null;
		service=null;
		view=null;
	}

	//==========================================================================================
	// evt listeners
	//==========================================================================================
	private function updatedMessage(event:MessageEvent):void {
		var list:IList=view.dataProvider;

		var f:int=-1;
		var fmax:int=list.length;
		var message:Message;

		while (++f < fmax) {
			message=list.getItemAt(f) as Message;

			if (message.id === event.message.id) {
				list.setItemAt(event.message, f);
				return;
			}
		}
	}

	private function removedMessage(event:MessageEvent):void {
		var list:IList=view.dataProvider;

		var f:int, fmax:int;
		var msg:Message;
		f=list.length / 2;
		msg=list.getItemAt(f) as Message;

		if (event.messageId === msg.id) {
			list.removeItemAt(f);
			return;
		} else if (event.messageId > msg.id) {
			f=list.length;
			while (--f >= 0) {
				msg=list.getItemAt(f) as Message;

				if (msg.id === event.messageId) {
					list.removeItemAt(f);
					return;
				}
			}
		} else {
			f=-1;
			fmax=list.length;
			while (++f < fmax) {
				msg=list.getItemAt(f) as Message;

				if (msg.id === event.messageId) {
					list.removeItemAt(f);
					return;
				}
			}
		}
	}

	private function addedMessage(event:MessageEvent):void {
		trace("ssen.mvc.examples.basic.views.MessageLogMediator.addedMessage(", event, ")");
		var list:IList=view.dataProvider;
		list.addItem(event.message);
	}
}
}
