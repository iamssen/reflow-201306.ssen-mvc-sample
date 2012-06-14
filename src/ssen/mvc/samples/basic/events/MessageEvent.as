package ssen.mvc.samples.basic.events {
	import flash.events.Event;

	public class MessageEvent extends Event {
		public static const CREATED_NEW_MESSAGE:String="createdNewMessage";
		public static const TEXT_IS_BLANK:String="textIsBlank";
		public static const ADD_MESSAGE:String="addMessage";
		public static const REMOVE_MESSAGE:String="removeMessage";
		public static const REMOVED_MESSAGE:String="removedMessage";

		public var text:String;
		public var messageId:int;

		public function MessageEvent(type:String) {
			super(type);
		}

		override public function clone():Event {
			var clone:MessageEvent=new MessageEvent(type);
			clone.messageId=messageId;
			clone.text=text;

			return clone;
		}

		override public function toString():String {
			return formatToString("MessageControlEvent", "type", "text", "messageId");
		}


	}
}
