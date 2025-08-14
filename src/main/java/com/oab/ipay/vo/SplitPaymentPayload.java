package com.oab.ipay.vo;

public class SplitPaymentPayload {

	private String splitTranId;
	private String reference;
	private String aliasName;
	private String splitAmount;
	private String notes;
	private String description;
	private String type;

	public String getSplitTranId() {
		return splitTranId;
	}

	public void setSplitTranId(String splitTranId) {
		this.splitTranId = splitTranId;
	}

	public String getReference() {
		return reference;
	}

	public void setReference(String reference) {
		this.reference = reference;
	}

	public String getAliasName() {
		return aliasName;
	}

	public void setAliasName(String aliasName) {
		this.aliasName = aliasName;
	}

	public String getSplitAmount() {
		return splitAmount;
	}

	public void setSplitAmount(String splitAmount) {
		this.splitAmount = splitAmount;
	}

	public String getNotes() {
		return notes;
	}

	public void setNotes(String notes) {
		this.notes = notes;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

}
