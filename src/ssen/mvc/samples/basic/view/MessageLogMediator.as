package ssen.mvc.samples.basic.view {
	import mx.collections.ArrayList;
	import mx.collections.IList;

	import ssen.mvc.core.IContextDispatcher;
	import ssen.mvc.core.IMediator;
	import ssen.mvc.samples.basic.events.MessageErrorEvent;
	import ssen.mvc.samples.basic.events.MessageEvent;
	import ssen.mvc.samples.basic.model.Message;
	import ssen.mvc.samples.basic.model.MessageModel;

	public class MessageLogMediator implements IMediator {
		[Inject]
		public var dispatcher:IContextDispatcher;

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
			dispatcher.removeEventListener(MessageEvent.CREATED_NEW_MESSAGE, createdNewMessage);
			dispatcher.removeEventListener(MessageEvent.REMOVED_MESSAGE, removedMessage);

			view.deconstruct();
			view=null;
			list=null;
		}

		public function onRegister():void {
			dispatcher.addEventListener(MessageEvent.CREATED_NEW_MESSAGE, createdNewMessage);
			dispatcher.addEventListener(MessageEvent.REMOVED_MESSAGE, removedMessage);
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

		private function createdNewMessage(event:MessageEvent):void {
			model.getMessage(event.messageId, function(message:Message):void {
				list.addItem(message);
			}, function(error:Error):void {
				var evt:MessageErrorEvent=new MessageErrorEvent(MessageErrorEvent.UNDEFINED_MESSAGE,
																error.message);
				evt.messageId=event.messageId;
				dispatcher.dispatch(evt);
			});
		}
	}
}
