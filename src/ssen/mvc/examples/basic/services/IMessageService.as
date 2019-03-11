package ssen.mvc.examples.basic.services {
import ssen.common.IAsyncUnit;

/** Message Service Model */
public interface IMessageService {
	function addMessage(text:String):IAsyncUnit;
	function updateMessage(id:int, text:String):IAsyncUnit;
	function getMessage(id:int):IAsyncUnit;
	function getMessages(startId:int=0, endId:int=2147483647):IAsyncUnit;
	function removeMessage(id:int):IAsyncUnit;
	function removeMessages(ids:Vector.<int>):IAsyncUnit;
	function removeAllMessages():IAsyncUnit;
}
}
