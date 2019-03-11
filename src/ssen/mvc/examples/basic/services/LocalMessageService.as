package ssen.mvc.examples.basic.services {
//=========================================================
// MessageModel 을 Local 상에서 테스트 가능하게 구현한 Class 입니다.
//=========================================================

import ssen.common.IAsyncUnit;
import ssen.common.MathUtils;
import ssen.datakit.asyncunits.SetTimeoutAsyncUnit;
import ssen.mvc.examples.basic.models.Message;

public class LocalMessageService implements IMessageService {
	private var table:MessageTable;

	public function LocalMessageService() {
		table=new MessageTable;
	}

	//=========================================================
	// implements
	//=========================================================
	public function addMessage(text:String):IAsyncUnit {
		var msg:Message=table.addMessage(text);
		return new SetTimeoutAsyncUnit(100, msg);
	}

	public function updateMessage(id:int, text:String):IAsyncUnit {
		var msg:Message;
		if (table.updateMessage(id, text)) {
			msg=table.getMessage(id);
		}
		return new SetTimeoutAsyncUnit(MathUtils.rand(100, 1000), msg, new Error("update failed"), msg !== null);
	}

	public function getMessage(id:int):IAsyncUnit {
		var msg:Message=table.getMessage(id);
		return new SetTimeoutAsyncUnit(MathUtils.rand(100, 1000), msg, new Error("undefined failed"), msg !== null);
	}

	public function getMessages(startId:int=0, endId:int=2147483647):IAsyncUnit {
		var msgs:Vector.<Message>=table.getMessages(startId, endId);
		return new SetTimeoutAsyncUnit(MathUtils.rand(100, 1000), msgs, new Error("failed"), msgs !== null);
	}

	public function removeMessage(id:int):IAsyncUnit {
		var bool:Boolean=table.removeMessage(id);
		return new SetTimeoutAsyncUnit(MathUtils.rand(100, 1000), id, new Error("remove failed"), bool);
	}

	public function removeMessages(ids:Vector.<int>):IAsyncUnit {
		var bool:Boolean=table.removeMessages(ids);
		return new SetTimeoutAsyncUnit(MathUtils.rand(100, 1000), null, new Error("remove failed"), bool);
	}

	public function removeAllMessages():IAsyncUnit {
		var bool:Boolean=table.removeAllMessages();
		return new SetTimeoutAsyncUnit(MathUtils.rand(100, 1000), null, new Error("remove failed"), bool);
	}
}
}

//=========================================================
// helper class. data management table
//=========================================================
import ssen.common.ds.MultipleKeyDataCollection;
import ssen.mvc.examples.basic.models.Message;

class MessageTable extends MultipleKeyDataCollection {

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
