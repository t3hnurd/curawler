# curawler
Minimalistic curl crawler to grab HTTP/HTTPS headers

Lines are expected in the format IP:Port. For example 0.0.0.0:80

This script automatically shuffles the list to avoid raising suspicion with successive tests against the same or adjacent IP addresses. Each IP:Port line is tested for both HTTP and HTTPS responses using curl. Results are saved into one flat text file per line. These make good quick-references for surface level poking at websites.

Curl options can be tweaked if needed. This is the current breakdown:
-I  Grab headers
-L  Follow redirects
-k  Ignore certificate warnings
-s  Run silently (we only care about text file output)
-S  Show error messages (for analysis purposes)
-m  Set a maximum timeout value in seconds
-A  Set a custom user-agent string (can obviously be modified)

The script sleeps randomly between 1 and 10 seconds per test. Between sleeping and randomizing the test lines, this should be fairly gentle on most IP scopes.

You can build a list by starting with a set of IPs. Decide which ports to test (webservers commonly reside on 80, 443, 8080, and 8443, for example).

Convert the plain IP list into a set of IP:Port lines:

for i in $(cat ips.txt); do
  echo $i:{80,443,8080,8443} >> ip_with_ports.txt;
done

Clean up the list and make sure there is one entry per line:

tr -s ' ' '\n' < ip_with_ports.txt > ip_with_ports_clean.txt

Run the crawler:

./curawler.sh ip_with_ports_clean.txt

Please be ethical.
