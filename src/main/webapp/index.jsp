<!DOCTYPE html>
<html lang="en">
<head>
<title>Oman Arab Bank Merchant Sample Application</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="./css/bootstrap.min.css">
<%-- <script type="text/javascript" src="https://checkout.stripe.com/checkout.js"></script>  --%>
<script src="./css/jquery.min.js"></script>
<script src="./css/bootstrap.min.js"></script>
</head>
<body>

	<div class="container">
		<h2>Transaction Types</h2>
		<ul class="nav nav-tabs">
			<li id="bnkHstLink" class="active"><a href="#bankHosted">Bank Hosted Transaction</a></li>
			<li id="mrchHstLink"><a href="#merchantHosted">Merchant Hosted </a></li>
			<li id="mrchHstVbvLink"><a href="#merchantHostedVBV">Merchant Hosted 3d Secure Transaction</a></li>
			<li id="mrchHstVbvLinktcpip"><a href="#merchantHostedVBVtcpip">Merchant Hosted 3d Secure Transaction TCPIP</a></li>
			<li id="merchantHostedOabServiceLink"><a href="#merchantHostedOABService">Merchant Hosted OAB Service</a></li>
		</ul>

		<div class="tab-content">
			<div id="bankHosted" class="tab-pane fade in active">
				<h3></h3>
				<br />
				<jsp:include page="shopping/bankhosted/HostedPaymentdetailsHttp.jsp"></jsp:include>
			</div>
			<div id="merchantHostedOABService" class="tab-pane fade">
				<jsp:include page="shopping/merchanthostedoabservice/MerchostedCardInfoService.jsp"></jsp:include>
			</div>
		</div>
	</div>
	<script>
		$(document).ready(function() {
			$(".nav-tabs a").click(function() {
				$(this).tab('show');
			});
		});
	</script>

</body>
</html>