package ssen.mvc.samples.basic.model {

	public interface MessageModel {
		function addMessage(text:String, result:Function, fault:Function):void;
		function updateMessage(id:int, text:String, result:Function, fault:Function):void;
		function getMessages(startId:int=0, endId:int=2147483647, result:Function, fault:Function):void;
		function removeMessage(id:int, result:Function, fault:Function):void;
		function removeMessages(ids:Vector.<int>, result:Function, fault:Function):void;
		function removeAllMessages(result:Function, fault:Function):void;
	}
}
