package ssen.mvc.examples.basic.events {
import ssen.common.StringUtils;
import ssen.mvc.Evt;
import ssen.mvc.examples.basic.models.Message;

public class MessageEvent extends Evt {
	//=========================================================
	// event types
	//=========================================================
	/** 새로운 메세지 추가를 요청 */
	public static const ADD_MESSAGE:String="addMessage";
	/** 새로운 메세지가 추가 되었음을 알림 */
	public static const ADDED_MESSAGE:String="addedMessage";

	/** 메세지 삭제를 요청 */
	public static const REMOVE_MESSAGE:String="removeMessage";
	/** 메세지가 삭제 되었음을 알림 */
	public static const REMOVED_MESSAGE:String="removedMessage";

	/** 메세지 수정을 요청 */
	public static const UPDATE_MESSAGE:String="updateMessage";
	/** 메세지가 수정 되었음을 알림 */
	public static const UPDATED_MESSAGE:String="updatedMessage";

	public static const START_UPDATE:String="startUpdate";

	//=========================================================
	// parameters
	//=========================================================
	/** 입력할 message text */
	public var text:String;

	/** 입력된 model 측 message primary id */
	public var messageId:int;

	/** 작업된 서버측에서 생성된 message */
	public var message:Message;

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
