<%@page import="java.util.Calendar"%>
<%@page import="java.util.Random"%>
<%@ page language="java" session="true" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="java.io.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD html 4.01 Transitional//EN">
<head>
<script type="text/javascript">
function fnClickProcessMerchantHostServiceTransaction(){
	document.merchantHostedServiceTransaction.submit();
}

</script>

</head>
<div class="container">
	<div class="panel panel-default">
		<div class="panel-body">
			<form name="merchantHostedServiceTransaction" action="shopping/merchanthostedoabservice/MerchantHostedBuyService.jsp" method="post">
				<div class="form-group row">
					<label for="ActionLbl" class="col-sm-3 col-form-label">Action</label>
					<div class="col-sm-3">
						<select class="form-control" id="mrchHstServaction" name="action">
							<option value="PURCHASE"> PURCHASE</option> 
							<option value="VOID"> Void Purchase </option> 
							<option value="REFUND"> Refund </option>
							<option selected="selected" value="INQUIRY"> Inquiry </option> 
							<option value="11"> Token Registration</option>
							<option value="12"> Token De Registration </option> 
						</select>
					</div>
				</div>
				<div class="form-group row">
					<label for="ActionLbl" class="col-sm-3 col-form-label">Amount</label>
					<div class="col-sm-3">
						<input type="text" class="form-control" size="20" id="mrchHstServamount" name="amount" value="0.100" />
					</div>
				</div>

				<div class="form-group row">
					<label for="cardHolderLbl" class="col-sm-3 col-form-label">Transaction Id</label>
					<div class="col-sm-3">
						<input type="text" class="form-control" size="20" id="mrchHstServcomment" name="transid" value="" />
					</div>
				</div>
				<div class="form-group row">
					<label for="cardHolderLbl" class="col-sm-3 col-form-label">Split Transaction Id</label>
					<div class="col-sm-3">
						<input type="text" class="form-control" size="20" id="splitTranId" name="splitTranId" value="" />
					</div>
				</div>

				<div class="form-group row">
					<label for="cardHolderLbl" class="col-sm-3 col-form-label">Split Amount</label>
					<div class="col-sm-3">
						<input type="text" class="form-control" size="20" id="splitAmount" name="splitAmount" value="" />
					</div>
				</div>

				<div class="form-group row">
					<label for="cardHolderLbl" class="col-sm-3 col-form-label">Action By</label>
					<div class="col-sm-3">
						<select class="form-control" id="actionBy" name="actionBy" >
							<option value="PAYMENTID">PaymentID</option> 
							<option value="TRACKID">TrackID</option> 
							<option value="REFNO">SeqNum</option>
							<option value="TRANID">Original Transaction Id</option>
						</select>
					</div>
				</div>

				<div class="form-group row">
					<label for="cardHolderLbl" class="col-sm-3 col-form-label">Track Id</label>
					<div class="col-sm-3">
						<input type="text" class="form-control" size="20" id="mrchHstServtrackId" name="trckId" value="<%=String.valueOf(Calendar.getInstance().getTimeInMillis())%>" />
					</div>
				</div>

				<div class="form-group row">
					<label for="expireDateLbl" class="col-sm-3 col-form-label"></label>
					<div class="col-sm-4">
						<button onclick="fnClickProcessMerchantHostServiceTransaction();" id="mrchHstServButtonClick" type="button" class="btn btn-default">Process</button>
					</div>
				</div>
				
			</form>
		</div>
	</div>
</div>

