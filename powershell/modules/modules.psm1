#
# modules.psm1
#
function test-message {
	param(
		$msg
	)
	msg console $msg
}