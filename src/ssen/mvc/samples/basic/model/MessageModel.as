package ssen.mvc.samples.basic.model {

	public interface MessageModel {
		function addMessage(text:String, result:Function=null, fault:Function=null):void;
		function updateMessage(id:int, text:String, result:Function=null, fault:Function=null):void;
		function getMessage(id:int, result:Function=null, fault:Function=null):void;
		function getMessages(startId:int=0, endId:int=2147483647, result:Function=null,
							 fault:Function=null):void;
		function removeMessage(id:int, result:Function=null, fault:Function=null):void;
		function removeMessages(ids:Vector.<int>, result:Function=null, fault:Function=null):void;
		function removeAllMessages(result:Function=null, fault:Function=null):void;
	}
}
