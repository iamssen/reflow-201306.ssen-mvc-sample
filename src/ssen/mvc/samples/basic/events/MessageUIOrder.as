package ssen.mvc.samples.basic.events {
	import flash.events.Event;

	public class MessageUIOrder extends Event {
		public static const CREATED_NEW_MESSAGE:String="createdNewMessage";
		public static const TEXT_IS_BLANK:String="textIsBlank";

		public var messageId:int;

		public function MessageUIOrder(type:String) {
			super(type);
		}

		override public function clone():Event {
			var clone:MessageUIOrder=new MessageUIOrder(type);
			clone.messageId=messageId;

			return clone;
		}

		override public function toString():String {
			return formatToString("MessageUIOrder", "type", "messageId");
		}


	}
}
