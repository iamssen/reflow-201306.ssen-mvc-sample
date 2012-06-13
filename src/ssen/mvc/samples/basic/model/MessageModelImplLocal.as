package ssen.mvc.samples.basic.model {
	import flash.utils.setTimeout;

	import ssen.mvc.base.Actor;

	public class MessageModelImplLocal extends Actor implements MessageModel {
		private var table:MessageTable;

		public function MessageModelImplLocal() {
			table=new MessageTable;
		}

		public function addMessage(text:String, result:Function=null, fault:Function=null):void {
			setTimeout(function():void {
				var msg:Message=table.addMessage(text);

				if (result !== null) {
					result(msg);
				}
			}, 100);
		}

		public function updateMessage(id:int, text:String, result:Function=null, fault:Function=null):void {
		}

		public function getMessages(startId:int=0, endId:int=2147483647, result:Function=null,
									fault:Function=null):void {
		}

		public function removeMessage(id:int, result:Function=null, fault:Function=null):void {
		}

		public function removeMessages(ids:Vector.<int>, result:Function=null, fault:Function=null):void {
		}

		public function removeAllMessages(result:Function=null, fault:Function=null):void {
		}
	}
}
import ssen.common.DataTable;
import ssen.mvc.samples.basic.model.Message;
import ssen.mvc.samples.basic.model.MessageModel;

class MessageTable extends DataTable {

	public function addMessage(message:String):Message {
		var time:Date=new Date;

		var msg:Message=new Message;
		msg.id=_create({message: message, time: time});
		msg.text=message;
		msg.time=time;

		return msg;
	}

	public function getMessages(startId:int=0, endId:int=2147483647, result:Function=null,
								fault:Function=null):void {
		// TODO Auto Generated method stub

	}

	public function removeAllMessages(result:Function=null, fault:Function=null):void {
		// TODO Auto Generated method stub

	}

	public function removeMessage(id:int, result:Function=null, fault:Function=null):void {
		// TODO Auto Generated method stub

	}

	public function removeMessages(ids:Vector.<int>, result:Function=null, fault:Function=null):void {
		// TODO Auto Generated method stub

	}

	public function updateMessage(id:int, text:String, result:Function=null, fault:Function=null):void {
		// TODO Auto Generated method stub

	}

}
