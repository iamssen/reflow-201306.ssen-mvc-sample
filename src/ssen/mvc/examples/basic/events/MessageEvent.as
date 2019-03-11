package ssen.mvc.examples.basic.events {
import ssen.common.StringUtils;
import ssen.mvc.Evt;

public class MessageEvent extends Evt {
	//=========================================================
	// event types
	//=========================================================
	public static const ADD_MESSAGE:String="addMessage";
	public static const ADDED_MESSAGE:String="addedMessage";

	public static const REMOVE_MESSAGE:String="removeMessage";
	public static const REMOVED_MESSAGE:String="removedMessage";

	public static const UPDATE_MESSAGE:String="updateMessage";
	public static const UPDATED_MESSAGE:String="updatedMessage";

	public static const START_UPDATE:String="startUpdate";

	//=========================================================
	// parameters
	//=========================================================
	public var text:String;
	public var messageId:int;
	public var messageIndex:int;

	//=========================================================
	// 
	//=========================================================
	public function MessageEvent(type:String) {
		super(type);
	}

	public function toString():String {
		return StringUtils.formatToString('[MessageEvent type="{0}"]', type);
	}


}
}
