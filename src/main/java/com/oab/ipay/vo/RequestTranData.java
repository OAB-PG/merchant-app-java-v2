package com.oab.ipay.vo;

public class RequestTranData {

	private String trandata;
	private String webAddress;
	private String tranportalId;
	private String responseURL;
	private String errorURL;
	private String paymentId;

	public String getTranportalId() {
		return tranportalId;
	}

	public void setTranportalId(String tranportalId) {
		this.tranportalId = tranportalId;
	}

	public String getTrandata() {
		return trandata;
	}

	public void setTrandata(String trandata) {
		this.trandata = trandata;
	}

	public String getWebAddress() {
		return webAddress;
	}

	public void setWebAddress(String webAddress) {
		this.webAddress = webAddress;
	}

	public String getResponseURL() {
		return responseURL;
	}

	public void setResponseURL(String responseURL) {
		this.responseURL = responseURL;
	}

	public String getErrorURL() {
		return errorURL;
	}

	public void setErrorURL(String errorURL) {
		this.errorURL = errorURL;
	}

	public String getPaymentId() {
		return paymentId;
	}

	public void setPaymentId(String paymentId) {
		this.paymentId = paymentId;
	}

}
