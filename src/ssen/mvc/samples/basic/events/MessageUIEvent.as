package ssen.mvc.samples.basic.events {
	import flash.events.Event;

	import ssen.log.formatToString;

	public class MessageUIEvent extends Event {

		public static const ADD_MESSAGE:String="addMessage";

		public var message:String;
		public var messageId:int;

		public function MessageUIEvent(type:String) {
			super(type);
		}

		override public function clone():Event {
			var clone:MessageUIEvent=new MessageUIEvent(type);
			clone.message=message;
			clone.messageId=messageId;

			return clone;
		}

		override public function toString():String {
			return formatToString("MessageUIEvent", "type", "message", "messageId");
		}


	}
}
