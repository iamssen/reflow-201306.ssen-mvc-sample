package ssen.mvc.samples.basic.events {
	import flash.events.ErrorEvent;
	import flash.events.Event;

	public class MessageErrorEvent extends ErrorEvent {
		public static const ADDED_FAILED:String="addedFailed";

		public function MessageErrorEvent(type:String, text:String="", id:int=0) {
			super(type, false, false, text, id);
		}

		override public function clone():Event {
			return new MessageErrorEvent(type, text, errorID);
		}

		override public function toString():String {
			return formatToString("MessageErrorEvent", "type", "text", "errorID");
		}
	}
}
