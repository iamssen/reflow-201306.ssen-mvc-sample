package ssen.mvc.samples.basic.model {
	//=========================================================
	// MessageModel 을 Local 상에서 테스트 가능하게 구현한 Class 입니다.
	//=========================================================

	import flash.utils.setTimeout;

	import ssen.mvc.base.Actor;

	public class LocalMessageModel extends Actor implements MessageModel {
		private const DELAY:int = 100;
		private var table:MessageTable;

		public function LocalMessageModel() {
			table=new MessageTable;
		}

		//=========================================================
		// Actor 는 destruct 라는 
		// 1. Context 전체가 제거될때 내부 레퍼런스를 제거하거나
		// 2. Actor 스스로 제거될때 내부 레퍼런스를 제거하는
		// 기능을 제공합니다.
		// 
		// 1번의 경우는 Framework 에 의해 컨트롤 되고,
		// 2번의 경우는 내부적으로 자체 호출해주면 됩니다
		//=========================================================
		override protected function destruct():void {
			super.destruct();
			table=null;
		}

		//=========================================================
		// implements
		//=========================================================
		/** @inheritDoc */
		public function addMessage(text:String, result:Function=null, fault:Function=null):void {
			
			// server 측 데이터의 delay 를 흉내내기 위해서
			// setTimeout 을 사용합니다.
			setTimeout(function():void {
				var msg:Message=table.addMessage(text);

				if (result !== null) {
					result(msg);
				}
			}, DELAY);
		}

		/** @inheritDoc */
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
			}, DELAY);
		}

		/** @inheritDoc */
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
			}, DELAY);
		}

		/** @inheritDoc */
		public function getMessages(startId:int=0, endId:int=2147483647, result:Function=null,
									fault:Function=null):void {
			setTimeout(function():void {
				if (result !== null) {
					result(table.getMessages(startId, endId));
				}
			}, DELAY);
		}

		/** @inheritDoc */
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
			}, DELAY);
		}

		/** @inheritDoc */
		public function removeMessages(ids:Vector.<int>, result:Function=null, fault:Function=null):void {
			setTimeout(function():void {
				if (table.removeMessages(ids)) {
					if (result !== null) {
						result(ids);
					}
				} else {
					if (fault !== null) {
						fault(new Error("remove failed"));
					}
				}
			}, DELAY);
		}

		/** @inheritDoc */
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
			}, DELAY);
		}
	}
}

//=========================================================
// helper class. data management table
//=========================================================
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
