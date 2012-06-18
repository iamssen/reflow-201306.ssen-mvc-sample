package ssen.mvc.samples.basic.events {
	import flash.events.ErrorEvent;
	import flash.events.Event;

	public class MessageErrorEvent extends ErrorEvent {
		//=========================================================
		// event types
		//=========================================================
		/** 새로운 메세지 추가가 실패 */
		public static const ADD_FAILED:String="addFailed";
		
		/** 메세지 삭제가 실패 */
		public static const REMOVE_FAILED:String="removeFailed";
		
		/** 메세지 수정이 실패 */
		public static const UPDATE_FAILED:String="updateFailed";

		/** 조회하려는 메세지를 찾을 수 없음 */
		public static const UNDEFINED_MESSAGE:String="undefinedMessage";

		/** 입력하려는 메세지가 공백임 */
		public static const TEXT_IS_BLANK:String="textIsBlank";

		//=========================================================
		// parameters
		//=========================================================
		public var messageId:int;

		//=========================================================
		// 
		//=========================================================
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
