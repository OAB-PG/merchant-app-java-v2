package com.oab.ipay;

import com.oab.ipay.vo.Reply;
import com.oab.ipay.vo.Request;

public class OabIpayConnection extends OabIpayConnectionImpl {

	public OabIpayConnection() {
		super();
	}
	
	public OabIpayConnection(String proxyHost, Integer proxyPort) {
		super(true, proxyHost, proxyPort);
	}
	
	public Reply processInquiryByTrackId(Request req) throws Exception {
		return super.processInquiryByTrackId(req);
	}

	public Reply processInquiryByPaymentId(Request req) throws Exception {
		return super.processInquiryByPaymentId(req);
	}

	public Reply processInquiryByTranId(Request req) throws Exception {
		return super.processInquiryByTranId(req);
	}

	public Reply processInquiryByRefNo(Request req) throws Exception {
		return super.processInquiryByRefNo(req);
	}

	public Reply processRefundByTranId(Request req) throws Exception {
		return super.processRefundByTranId(req);
	}

	public Reply processSignedRefundByTranId(Request req) throws Exception {
		return super.processSignedRefundByTranId(req);
	}

	public Reply processReversalByTrackId(Request req) throws Exception {
		return super.processReversalByTrackId(req);
	}

	public Reply processReversalByTranId(Request req) throws Exception {
		return super.processReversalByTranId(req);
	}

	public Reply initiateTransaction(Request req) throws Exception {
		return super.initiateTransaction(req);
	}

	public Reply initiateSignedTransaction(Request req) throws Exception {
		return super.initiateSignedTransaction(req);
	}
	
}
