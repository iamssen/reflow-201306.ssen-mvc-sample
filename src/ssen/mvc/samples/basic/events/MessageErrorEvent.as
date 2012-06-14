package ssen.mvc.samples.basic.events {
	import flash.events.ErrorEvent;
	import flash.events.Event;

	public class MessageErrorEvent extends ErrorEvent {
		public static const ADDED_FAILED:String="addedFailed";
		public static const UNDEFINED_MESSAGE:String="undefinedMessage";
		public static const REMOVED_FAILED:String="removedFailed";

		public var messageId:int;

		public function MessageErrorEvent(type:String, text:String="", id:int=0) {
			super(type, false, false, text, id);
		}

		override public function clone():Event {
			var clone:MessageErrorEvent=new MessageErrorEvent(type, text, errorID);
			clone.messageId=messageId;

			return clone;
		}

		override public function toString():String {
			return formatToString("MessageErrorEvent", "type", "text", "errorID", "messageId");
		}
	}
}
