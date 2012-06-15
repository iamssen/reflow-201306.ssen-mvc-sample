package ssen.mvc.samples.basic.events {
	import flash.events.Event;

	public class MessageEvent extends Event {
		public static const ADD_MESSAGE:String="addMessage";
		public static const ADDED_MESSAGE:String="addedMessage";
		public static const REMOVE_MESSAGE:String="removeMessage";
		public static const REMOVED_MESSAGE:String="removedMessage";
		public static const TEXT_IS_BLANK:String="textIsBlank";

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
			return formatToString("MessageEvent", "type", "text", "messageId");
		}


	}
}
