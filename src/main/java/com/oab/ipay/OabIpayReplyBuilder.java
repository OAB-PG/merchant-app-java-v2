package com.oab.ipay;

import com.oab.ipay.key.KeyParser;
import com.oab.ipay.key.SecretUtil;
import com.oab.ipay.vo.Reply;
import com.oab.ipay.vo.ReplyTranData;

public class OabIpayReplyBuilder {
	
	public static Reply prepareReply(ReplyTranData tranData) throws Exception {
		return toPrepareReply(tranData);
	}
	
	private static Reply toPrepareReply(ReplyTranData tranData) throws Exception {
		KeyParser key = new KeyParser(tranData.getKeyPath(), tranData.getAlias());
		return SecretUtil.decrypt(key.getKey(), tranData.getTrandata());
	}

	public static Reply prepareSignedReply(ReplyTranData tranData) throws Exception {
		return toPrepareSignedReply(tranData);
	}

	private static Reply toPrepareSignedReply(ReplyTranData tranData) throws Exception {
		return SecretUtil.decrypt(tranData.getSignKey(), tranData.getTrandata());
	}

}
