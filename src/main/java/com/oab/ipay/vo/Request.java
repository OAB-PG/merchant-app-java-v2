package com.oab.ipay.vo;

import java.util.ArrayList;
import java.util.List;

import com.oab.ipay.key.SecretUtil;

public class Request {

	private String id;
	private String password;
	private String keyPath;
	private String alias;

	private String signKey;
	private String mode;

	private String action;
	private String amt;
	private String trackid;
	private String transid;
	private String tokenNo;
	private String tokenFlag;
	private String udf1;
	private String udf2;
	private String udf3;
	private String udf4;
	private String udf5;
	private String currencycode;
	private String langid;

	private String cardNo;
	private String cvv2;
	private String expMonth;
	private String expYear;
	private String cardName;

	private String card;
	private String expmonth;
	private String expyear;
	private String member;

	private String type;
	private String browserAcceptHeader;
	private String browserIP;
	private Boolean browserJavaEnabled;
	private Boolean browserJavascriptEnabled;
	private String browserLanguage;
	private String browserColorDepth;
	private String browserScreenHeight;
	private String browserScreenWidth;
	private String browserTZ;
	private String browserUserAgent;
	private String device;

	private String responseURL;
	private String errorURL;
	private String splitPaymentIndicator;
	private List<SplitPaymentPayload> splitPaymentPayload;

	private String notes;
	private String walletType;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getAction() {
		return action;
	}

	public void setAction(String action) {
		this.action = action;
	}

	public String getAmt() {
		return amt;
	}

	public void setAmt(String amt) {
		this.amt = amt;
	}

	public String getTrackid() {
		return trackid;
	}

	public void setTrackid(String trackid) {
		this.trackid = trackid;
	}

	public String getTransid() {
		return transid;
	}

	public void setTransid(String transid) {
		this.transid = transid;
	}

	public String getTokenNo() {
		return tokenNo;
	}

	public void setTokenNo(String tokenNo) {
		this.tokenNo = tokenNo;
	}

	public String getTokenFlag() {
		return tokenFlag;
	}

	public void setTokenFlag(String tokenFlag) {
		this.tokenFlag = tokenFlag;
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

	public String getCurrencycode() {
		return currencycode;
	}

	public void setCurrencycode(String currencycode) {
		this.currencycode = currencycode;
	}

	public String getLangid() {
		return langid;
	}

	public void setLangid(String langid) {
		this.langid = langid;
	}

	public String getCardNo() {
		return cardNo;
	}

	public void setCardNo(String cardNo) {
		this.cardNo = cardNo;
	}

	public String getCvv2() {
		return cvv2;
	}

	public void setCvv2(String cvv2) {
		this.cvv2 = cvv2;
	}

	public String getExpMonth() {
		return expMonth;
	}

	public void setExpMonth(String expMonth) {
		this.expMonth = expMonth;
	}

	public String getExpYear() {
		return expYear;
	}

	public void setExpYear(String expYear) {
		this.expYear = expYear;
	}

	public String getCardName() {
		return cardName;
	}

	public void setCardName(String cardName) {
		this.cardName = cardName;
	}

	public String getCard() {
		return card;
	}

	public void setCard(String card) {
		this.card = card;
	}

	public String getExpmonth() {
		return expmonth;
	}

	public void setExpmonth(String expmonth) {
		this.expmonth = expmonth;
	}

	public String getExpyear() {
		return expyear;
	}

	public void setExpyear(String expyear) {
		this.expyear = expyear;
	}

	public String getMember() {
		return member;
	}

	public void setMember(String member) {
		this.member = member;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getBrowserAcceptHeader() {
		return browserAcceptHeader;
	}

	public void setBrowserAcceptHeader(String browserAcceptHeader) {
		this.browserAcceptHeader = browserAcceptHeader;
	}

	public String getBrowserIP() {
		return browserIP;
	}

	public void setBrowserIP(String browserIP) {
		this.browserIP = browserIP;
	}

	public Boolean getBrowserJavaEnabled() {
		return browserJavaEnabled;
	}

	public void setBrowserJavaEnabled(Boolean browserJavaEnabled) {
		this.browserJavaEnabled = browserJavaEnabled;
	}

	public Boolean getBrowserJavascriptEnabled() {
		return browserJavascriptEnabled;
	}

	public void setBrowserJavascriptEnabled(Boolean browserJavascriptEnabled) {
		this.browserJavascriptEnabled = browserJavascriptEnabled;
	}

	public String getBrowserLanguage() {
		return browserLanguage;
	}

	public void setBrowserLanguage(String browserLanguage) {
		this.browserLanguage = browserLanguage;
	}

	public String getBrowserColorDepth() {
		return browserColorDepth;
	}

	public void setBrowserColorDepth(String browserColorDepth) {
		this.browserColorDepth = browserColorDepth;
	}

	public String getBrowserScreenHeight() {
		return browserScreenHeight;
	}

	public void setBrowserScreenHeight(String browserScreenHeight) {
		this.browserScreenHeight = browserScreenHeight;
	}

	public String getBrowserScreenWidth() {
		return browserScreenWidth;
	}

	public void setBrowserScreenWidth(String browserScreenWidth) {
		this.browserScreenWidth = browserScreenWidth;
	}

	public String getBrowserTZ() {
		return browserTZ;
	}

	public void setBrowserTZ(String browserTZ) {
		this.browserTZ = browserTZ;
	}

	public String getBrowserUserAgent() {
		return browserUserAgent;
	}

	public void setBrowserUserAgent(String browserUserAgent) {
		this.browserUserAgent = browserUserAgent;
	}

	public String getDevice() {
		return device;
	}

	public void setDevice(String device) {
		this.device = device;
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

	public String getSplitPaymentIndicator() {
		return splitPaymentIndicator;
	}

	public void setSplitPaymentIndicator(String splitPaymentIndicator) {
		this.splitPaymentIndicator = splitPaymentIndicator;
	}

	public List<SplitPaymentPayload> getSplitPaymentPayload() {
		return this.splitPaymentPayload;
	}

	public void setSplitPaymentPayload(List<SplitPaymentPayload> splitPaymentPayload) {
		this.splitPaymentPayload = splitPaymentPayload;
	}

	public void addSplitPaymentPayload(SplitPaymentPayload splitPaymentPayload) {
		this.splitPaymentPayload = this.splitPaymentPayload == null ? new ArrayList<>() : this.splitPaymentPayload;
		this.splitPaymentPayload.add(splitPaymentPayload);
	}

	public String getKeyPath() {
		return keyPath;
	}

	public void setKeyPath(String keyPath) {
		this.keyPath = keyPath;
	}

	public String getSignKey() {
		return signKey;
	}

	public void setSignKey(String signKey) {
		this.signKey = signKey;
	}

	public String getMode() {
		return mode;
	}

	public void setMode(String mode) {
		this.mode = mode;
	}

	public String getAlias() {
		return alias;
	}

	public void setAlias(String alias) {
		this.alias = alias;
	}

	public String getPassword() {
		return password;
	}

	public String getData(String key) throws Exception {
		return SecretUtil.encrypt(this, key);
	}

	public String getNotes() {
		return notes;
	}

	public void setNotes(String notes) {
		this.notes = notes;
	}

	public String getWalletType() {
		return walletType;
	}

	public void setWalletType(String walletType) {
		this.walletType = walletType;
	}

}