# # domain labels
# id=$(docker run -d \
#   -v /var/run/docker.sock:/var/run/docker.sock \
#   -l raider.auth.domains=localhost,raiderarts.net \
#   raiderauth)
# sleep 1s
# docker exec $id cat /usr/local/bin/config/config.yml
# # docker rm $id --force
# echo "------------------------------------------------------------------------"

# id=$(docker run -d \
#   -v /var/run/docker.sock:/var/run/docker.sock \
#   raiderauth)
# sleep 1s
# docker exec $id cat /usr/local/bin/config/config.yml
# # docker rm $id --force
# echo "------------------------------------------------------------------------"

# id=$(docker run -d \
#   -v /var/run/docker.sock:/var/run/docker.sock \
#   -l raider.auth.cookie.domain=localhost \
#   -l raider.auth.cookie.secure=true \
#   -l raider.auth.allowAllUsers=true \
#   raiderauth)
# sleep 1s
# docker exec $id cat /usr/local/bin/config/config.yml

# echo "------------------------------------------------------------------------"

id=$(docker run -d \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -l raider.auth.cookie.domain=localhost \
  -l raider.auth.cookie.secure=false \
  -l raider.auth.allowAllUsers=true \
  --env-file .env \
  -p 6090:9090 \
  raiderauth)
sleep 1s
docker exec $id cat /usr/local/bin/config/config.yml
# docker rm $id --force