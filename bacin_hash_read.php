#!/usr/bin/php
<?php
#curl -H 'content-length: 0' -X GET http://radish.dishanywhere.com/heartbeat/undefined
$data = json_decode(file_get_contents('http://radish.dishanywhere.com/heartbeat/undefined'));
print "Current hash: " . $data->bacin . "\n";

#echo "Available DBA handlers:\n";
#foreach (dba_handlers(true) as $handler_name => $handler_version) {
#  // clean the versions
#  $handler_version = str_replace('$', '', $handler_version);
#  echo " - $handler_name: $handler_version\n";
#}

# write to file
$id = dba_open("bacin_hash.db", "n", "inifile");
if (!$id) {
        print "dba_open failed\n";
        exit;
}
dba_insert("bacin", $data->bacin, $id);
dba_close($id);
?>
