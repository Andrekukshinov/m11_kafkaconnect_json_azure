KEY=`cat key.txt`
echo "$KEY"
sed "s#USE_KEY_HERE#$KEY#" ./connectors/azure-source-cc-expedia.json > ./connectors/res.json
curl -s -X POST -H "Content-Type: application/json" --data @connectors/res.json http://127.0.0.1:8083/connectors
rm ./connectors/res.json