package ssen.mvc.examples.basic.models {
import flash.utils.Dictionary;

import mx.collections.ArrayList;
import mx.collections.IList;

import ssen.mvc.IEventBus;
import ssen.mvc.examples.basic.events.MessageEvent;

public class MessageModel {
	[Inject]
	public var eventBus:IEventBus;

	[Bindable]
	public var list:IList=new ArrayList;

	private var index:Dictionary=new Dictionary;

	public function added(message:Message):void {
		var i:int=list.length;
		list.addItemAt(message, i);
		index[message.id]=message;

		var evt:MessageEvent=new MessageEvent(MessageEvent.ADDED_MESSAGE);
		evt.messageIndex=i;
		eventBus.dispatchEvent(evt);
	}

	public function updated(message:Message):void {
		var i:int=list.getItemIndex(index[message.id]);
		if (i > -1) {
			list.setItemAt(message, i);
			index[message.id]=message;

			var evt:MessageEvent=new MessageEvent(MessageEvent.UPDATED_MESSAGE);
			evt.messageIndex=i;
			eventBus.dispatchEvent(evt);
		}
	}

	public function removed(id:int):void {
		var i:int=list.getItemIndex(index[id]);
		if (i > -1) {
			list.removeItemAt(i);
			delete index[id];

			var evt:MessageEvent=new MessageEvent(MessageEvent.REMOVED_MESSAGE);
			evt.messageIndex=list.length - 1;
			eventBus.dispatchEvent(evt);
		}
	}
}
}
