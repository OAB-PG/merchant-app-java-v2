package com.oab.ipay.vo;

import java.util.ArrayList;
import java.util.List;

public class Reply {

	private String result;
	private String paymentId;
	private String tranId;
	private String date;
	private String udf1;
	private String udf2;
	private String udf3;
	private String udf4;
	private String udf5;
	private String trackId;
	private String auth;
	private String amt;
	private String ref;
	private String currency;
	private String error;
	private String errorText;
	private String tokenNo;
	private String tranDate;
	private String tranRequestDate;
	private String tranResponseDate;
	private List<SplitPaymentPayload> splitPaymentPayload;

	private String redirectUrl;

	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
	}

	public String getPaymentId() {
		return paymentId;
	}

	public void setPaymentId(String paymentId) {
		this.paymentId = paymentId;
	}

	public String getTranId() {
		return tranId;
	}

	public void setTranId(String tranId) {
		this.tranId = tranId;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getUdf1() {
		return udf1;
	}

	public void setUdf1(String udf1) {
		this.udf1 = udf1;
	}

	public String getUdf2() {
		return udf2;
	}

	public void setUdf2(String udf2) {
		this.udf2 = udf2;
	}

	public String getUdf3() {
		return udf3;
	}

	public void setUdf3(String udf3) {
		this.udf3 = udf3;
	}

	public String getUdf4() {
		return udf4;
	}

	public void setUdf4(String udf4) {
		this.udf4 = udf4;
	}

	public String getUdf5() {
		return udf5;
	}

	public void setUdf5(String udf5) {
		this.udf5 = udf5;
	}

	public String getTrackId() {
		return trackId;
	}

	public void setTrackId(String trackId) {
		this.trackId = trackId;
	}

	public String getAuth() {
		return auth;
	}

	public void setAuth(String auth) {
		this.auth = auth;
	}

	public String getAmt() {
		return amt;
	}

	public void setAmt(String amt) {
		this.amt = amt;
	}

	public String getRef() {
		return ref;
	}

	public void setRef(String ref) {
		this.ref = ref;
	}

	public String getCurrency() {
		return currency;
	}

	public void setCurrency(String currency) {
		this.currency = currency;
	}

	public String getError() {
		return error;
	}

	public void setError(String error) {
		this.error = error;
	}

	public String getErrorText() {
		return errorText;
	}

	public void setErrorText(String errorText) {
		this.errorText = errorText;
	}

	public String getTokenNo() {
		return tokenNo;
	}

	public void setTokenNo(String tokenNo) {
		this.tokenNo = tokenNo;
	}

	public String getTranDate() {
		return tranDate;
	}

	public void setTranDate(String tranDate) {
		this.tranDate = tranDate;
	}

	public String getTranRequestDate() {
		return tranRequestDate;
	}

	public void setTranRequestDate(String tranRequestDate) {
		this.tranRequestDate = tranRequestDate;
	}

	public String getTranResponseDate() {
		return tranResponseDate;
	}

	public void setTranResponseDate(String tranResponseDate) {
		this.tranResponseDate = tranResponseDate;
	}

	public String getRedirectUrl() {
		return redirectUrl;
	}

	public void setRedirectUrl(String redirectUrl) {
		this.redirectUrl = redirectUrl;
	}

	public List<SplitPaymentPayload> getSplitPaymentPayload() {
		return splitPaymentPayload;
	}

	public void addSplitPaymentPayload(SplitPaymentPayload splitPaymentPayload) {
		this.splitPaymentPayload = this.splitPaymentPayload == null ? new ArrayList<>() : this.splitPaymentPayload;
		this.splitPaymentPayload.add(splitPaymentPayload);
	}

	public void setSplitPaymentPayload(List<SplitPaymentPayload> splitPaymentPayload) {
		this.splitPaymentPayload = splitPaymentPayload;
	}

}