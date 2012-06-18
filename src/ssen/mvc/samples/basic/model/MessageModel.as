package ssen.mvc.samples.basic.model {
	//=========================================================
	// 이 프로그램에 필요한 데이터를 유통시킬 수 있는 기능에 대해 정의 합니다.
	// 이 프로그램이 어떤 기능을 가지게 되는가? 에 대한 정의이며,
	// UI 관련된 기능들은 빼고 원론적 유형을 생각하면 됩니다.
	//
	// Interface 를 기준으로 하는 이유는 "교환가능성" 에 대한 고려가 됩니다.
	// 예를 들어 Web 에서 Remote Server 에 데이터를 주고 받는 것과
	// AIR 에서 SQLite 와 데이터를 주고 받는 것은 
	// 같은 interface 에 구현이 틀려지는 형태가 될 수 있기 때문입니다.
	//=========================================================

	/** Message Service Model */
	public interface MessageModel {
		/**
		 * message 생성
		 * @param text 생성할 text
		 * @param result result(message:Message):void
		 * @param fault fault(error:Error):void
		 */
		function addMessage(text:String, result:Function=null, fault:Function=null):void;

		/**
		 * message 수정
		 * @param id 수정할 message primary id
		 * @param text 수정할 text
		 * @param result result(message:Message):void
		 * @param fault fault(error:Error):void
		 */
		function updateMessage(id:int, text:String, result:Function=null, fault:Function=null):void;

		/**
		 * message 를 가져옴
		 * @param id 가져올 message primary id
		 * @param result result(message:Message):void
		 * @param fault fault(error:Error):void
		 */
		function getMessage(id:int, result:Function=null, fault:Function=null):void;

		/**
		 * message 들을 가져옴
		 * @param startId 가져올 message primary id start
		 * @param endId 가져올 message primary id end
		 * @param result result(messages:Vector.<Message>):void
		 * @param fault fault(error:Error):void
		 */
		function getMessages(startId:int=0, endId:int=2147483647, result:Function=null,
							 fault:Function=null):void;

		/**
		 * message 를 삭제함
		 * @param id 삭제할 message primary id
		 * @param result result(id:int):void
		 * @param fault fault(error:Error):void
		 */
		function removeMessage(id:int, result:Function=null, fault:Function=null):void;

		/**
		 * message 들을 삭제함
		 * @param ids 삭제할 message primary id array
		 * @param result result(ids:Vector.<int>):void
		 * @param fault fault(error:Error):void
		 */
		function removeMessages(ids:Vector.<int>, result:Function=null, fault:Function=null):void;

		/**
		 * 모든 message 들을 삭제함
		 * @param result result():void
		 * @param fault fault(error:Error):void
		 */
		function removeAllMessages(result:Function=null, fault:Function=null):void;
	}
}
