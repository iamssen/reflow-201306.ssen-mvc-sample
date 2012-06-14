package ssen.mvc.samples.basic.model {
	import flash.utils.setTimeout;
	
	import ssen.mvc.base.Actor;

	public class LocalMessageModel extends Actor implements MessageModel {
		private var table:MessageTable;

		public function LocalMessageModel() {
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
			setTimeout(function():void {
				if (table.updateMessage(id, text)) {
					if (result !== null) {
						result(table.getMessage(id));
					}
				} else {
					if (fault !== null) {
						fault(new Error("update failed"));
					}
				}
			}, 100);
		}

		public function getMessage(id:int, result:Function=null, fault:Function=null):void {
			setTimeout(function():void {
				var msg:Message=table.getMessage(id);

				if (msg !== null) {
					if (result !== null) {
						result(msg);
					}
				} else {
					if (fault !== null) {
						fault(new Error("undefined msg"));
					}
				}
			}, 100);
		}

		public function getMessages(startId:int=0, endId:int=2147483647, result:Function=null,
									fault:Function=null):void {
			setTimeout(function():void {
				if (result !== null) {
					result(table.getMessages(startId, endId));
				}
			}, 100);
		}

		public function removeMessage(id:int, result:Function=null, fault:Function=null):void {
			setTimeout(function():void {
				if (table.removeMessage(id)) {
					if (result !== null) {
						result(id);
					}
				} else {
					if (fault !== null) {
						fault(new Error("remove failed"));
					}
				}
			}, 100);
		}

		public function removeMessages(ids:Vector.<int>, result:Function=null, fault:Function=null):void {
			setTimeout(function():void {
				if (table.removeMessages(ids)) {
					if (result !== null) {
						result();
					}
				} else {
					if (fault !== null) {
						fault(new Error("remove failed"));
					}
				}
			}, 100);
		}

		public function removeAllMessages(result:Function=null, fault:Function=null):void {
			setTimeout(function():void {
				if (table.removeAllMessages()) {
					if (result !== null) {
						result();
					}
				} else {
					if (fault !== null) {
						fault(new Error("remove failed"));
					}
				}
			}, 100);
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

	public function getMessage(id:int):Message {
		var obj:Object=_read(id);

		var msg:Message=new Message;
		msg.id=id;
		msg.text=obj["message"];
		msg.time=obj["time"];

		return msg;
	}

	public function getMessages(startId:int=0, endId:int=2147483647):Vector.<Message> {
		var msgs:Vector.<Message>=new Vector.<Message>;
		var msg:Message, obj:Object;

		var f:int=startId - 1;
		var fmax:int=(endId <= length) ? endId : length;

		while (++f < fmax) {
			obj=_read(f);

			if (obj) {
				msg=new Message;
				msg.id=f;
				msg.text=obj["message"];
				msg.time=obj["time"];

				msgs.push(msg);
			}
		}

		return msgs;
	}

	public function removeAllMessages():Boolean {
		_purge();
		return true;
	}

	public function removeMessage(id:int):Boolean {
		return _delete(id) !== null;
	}

	public function removeMessages(ids:Vector.<int>):Boolean {
		var f:int=ids.length;
		while (--f >= 0) {
			_delete(ids[f]);
		}

		return true;
	}

	public function updateMessage(id:int, text:String):Boolean {
		return _update(id, {message: text}) !== null;
	}

}
