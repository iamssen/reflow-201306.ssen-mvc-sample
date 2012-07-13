package ssen.mvc.samples.basic.view {
	import mx.collections.ArrayList;
	import mx.collections.IList;
	
	import ssen.mvc.core.IEventBus;
	import ssen.mvc.core.IMediator;
	import ssen.mvc.samples.basic.events.MessageErrorEvent;
	import ssen.mvc.samples.basic.events.MessageEvent;
	import ssen.mvc.samples.basic.model.Message;
	import ssen.mvc.samples.basic.model.MessageModel;

	public class MessageLogMediator implements IMediator {
		[Inject]
		public var eventBus:IEventBus;

		[Inject]
		public var model:MessageModel;

		private var view:MessageLog;
		private var list:IList;

		public function setView(view:Object):void {
			list=new ArrayList;

			this.view=view as MessageLog;
			this.view.setDataProvider(list);
		}

		public function onRemove():void {
			eventBus.removeEventListener(MessageEvent.ADDED_MESSAGE, addedMessage);
			eventBus.removeEventListener(MessageEvent.UPDATED_MESSAGE, updatedMessage);
			eventBus.removeEventListener(MessageEvent.REMOVED_MESSAGE, removedMessage);

			view.deconstruct();
			view=null;
			list=null;
		}

		public function onRegister():void {
			eventBus.addEventListener(MessageEvent.ADDED_MESSAGE, addedMessage);
			eventBus.addEventListener(MessageEvent.UPDATED_MESSAGE, updatedMessage);
			eventBus.addEventListener(MessageEvent.REMOVED_MESSAGE, removedMessage);
		}

		private function updatedMessage(event:MessageEvent):void {
			var f:int=-1;
			var fmax:int=list.length;
			var message:Message;

			while (++f < fmax) {
				message=list.getItemAt(f) as Message;
				
				if (message.id === event.message.id) {
					list.setItemAt(event.message, f);
//					list.itemUpdated(
					
					return;
				}
			}
		}

		private function removedMessage(event:MessageEvent):void {
			trace("MessageLogMediator.removedMessage", event);

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
			list.addItem(event.message);
			//			model.getMessage(event.messageId, function(message:Message):void {
			//				list.addItem(message);
			//			}, function(error:Error):void {
			//				var evt:MessageErrorEvent=new MessageErrorEvent(MessageErrorEvent.UNDEFINED_MESSAGE,
			//																error.message);
			//				evt.messageId=event.messageId;
			//				dispatcher.dispatch(evt);
			//			});
		}
	}
}
