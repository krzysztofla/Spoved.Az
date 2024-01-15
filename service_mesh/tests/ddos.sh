url=http://localhost:30008/
url_azure=http://20.215.80.155

number_requests=20

sleep_time=1

for((i=1; i<=number_requests; i++)) do
    echo "Sending request $i to $url."
    resp=$(curl -s $url)
    echo "Resonse rcived: $resp"
    sleep $sleep_time
done