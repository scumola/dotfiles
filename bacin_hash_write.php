#!/usr/bin/php
<?php
#curl -H 'content-length: 0' -X PUT 'http://prod-radish01-app01.dishanywhere.com:3000/admin/api/update_bacin_hash/b377b8452aab6bb7f8b89c263a11afc1046dcd40?cheesy_admin_security=nechotech'

# read from file
$id = dba_open("bacin_hash.db", "r", "inifile");
if (!$id) {
        echo "dba_open failed\n";
        exit;
}
$bacin = dba_fetch("bacin", $id);
dba_close($id);
print "Saved hash: $bacin\n";

# Push saved hash to production
$ch = curl_init("http://prod-radish01-app01.dishanywhere.com:3000/admin/api/update_bacin_hash/$bacin?cheesy_admin_security=nechotech");
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
curl_setopt($ch, CURLOPT_CUSTOMREQUEST, "PUT");
$response = curl_exec($ch);
if(!$response) {
	print ("FAILURE PUT'ing hash to production\n");
} else {
	print ("SUCCESS PUT'ing hash to production\n");
}

# check current hash
$data = json_decode(file_get_contents('http://radish.dishanywhere.com/heartbeat/undefined'));
print "Current hash: " . $data->bacin . "\n";
?>
