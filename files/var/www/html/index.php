<?php  
  header ("Content-Type: text/plain");

  $host = gethostname();

  $ip = exec('hostname -I');
  if ( $ip == null ) $ip = $_SERVER['SERVER_ADDR'];

  $hn = gethostbyaddr($ip);
  printf("My-Hostname (gethostname): %s, IP: %s, Hostname (gethostbyaddr): %s\n", $host, $ip, $hn ); 


  $domain="www.actilis.net";
  //  putenv('RES_OPTIONS=retrans:1 retry:1 timeout:1 attempts:1');
  echo "DNS questions about $domain\n";
  echo 'gethostbynamel(): '; var_dump(gethostbynamel($domain));
  echo 'checkdnsrr(): ';     var_dump(checkdnsrr($domain, 'A'));
  echo 'dns_get_record(): '; var_dump(dns_get_record($domain));

?>

