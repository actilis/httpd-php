<?php  
  $host = gethostname();

  $ip = exec('hostname -I');
  if ( $ip == null ) $ip = $_SERVER['SERVER_ADDR'];

  printf("Hostname: %s, IP: %s\n", $host, $ip ); 
?>
