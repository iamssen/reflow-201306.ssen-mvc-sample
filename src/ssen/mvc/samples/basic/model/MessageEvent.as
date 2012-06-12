package ssen.mvc.samples.basic.model {
	import flash.events.Event;

	public class MessageEvent extends Event {
		
		public var message:String;
		
		public function MessageEvent(type:String) {
			super(type);
		}
	}
}
