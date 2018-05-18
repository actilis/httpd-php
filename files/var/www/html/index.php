<?php  
  $host = gethostname();

  $ip = exec('hostname -I');
  if ( $ip == null ) $ip = $_SERVER['SERVER_ADDR'];

  printf("My-Hostname: %s, IP: %s\n", $host, $ip ); 
?>
