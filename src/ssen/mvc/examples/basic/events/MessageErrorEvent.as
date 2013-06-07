package ssen.mvc.examples.basic.events {
import ssen.common.StringUtils;
import ssen.mvc.Evt;

public class MessageErrorEvent extends Evt {
	//=========================================================
	// event types
	//=========================================================
	/** 새로운 메세지 추가가 실패 */
	public static const ADD_FAILED:String="addFailed";

	/** 메세지 삭제가 실패 */
	public static const REMOVE_FAILED:String="removeFailed";

	/** 메세지 수정이 실패 */
	public static const UPDATE_FAILED:String="updateFailed";

	/** 조회하려는 메세지를 찾을 수 없음 */
	public static const UNDEFINED_MESSAGE:String="undefinedMessage";

	/** 입력하려는 메세지가 공백임 */
	public static const TEXT_IS_BLANK:String="textIsBlank";

	//=========================================================
	// parameters
	//=========================================================
	public var messageId:int;

	//=========================================================
	// 
	//=========================================================
	public function MessageErrorEvent(type:String, text:String="") {
		super(type);
	}

	public function toString():String {
		return StringUtils.formatToString('[MessageErrorEvent type="{0}"]', type);
	}
}
}
