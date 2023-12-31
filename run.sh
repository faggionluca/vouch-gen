id=$(docker run -d \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -l vouch.domains=localhost,raiderarts.net \
  raiderauth)
sleep 1s
docker exec $id cat /usr/local/bin/config/config.yml
docker rm $id --force
echo "------------------------------------------------------------------------"

id=$(docker run -d \
  -v /var/run/docker.sock:/var/run/docker.sock \
  raiderauth)
sleep 1s
docker exec $id cat /usr/local/bin/config/config.yml
docker rm $id --force
echo "------------------------------------------------------------------------"

id=$(docker run -d \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -l vouch.cookie.domain=localhost \
  -l vouch.cookie.secure=true \
  -l vouch.allowAllUsers=true \
  raiderauth)
sleep 1s
docker exec $id cat /usr/local/bin/config/config.yml

# echo "------------------------------------------------------------------------"

id=$(docker run -d \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -l vouch.cookie.secure=false \
  -l "vouch.teamWhitelist=Raider-Arts/Caprover-Admins" \
  --env-file .env \
  -p 6090:9090 \
  raiderauth)
sleep 1s
docker exec $id cat /usr/local/bin/config/config.yml
# docker rm $id --force