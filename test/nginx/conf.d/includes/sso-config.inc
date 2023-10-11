location = /test {
  proxy_pass http://vouch-gen:9090/login;
}

location ^~ /sso {
  proxy_pass http://vouch-gen:9090; # must not! have a slash at the end
  proxy_set_header Host $http_host;
  proxy_pass_request_body off;
  proxy_set_header Content-Length "";

  # these return values are used by the @error401 call
  auth_request_set $auth_resp_jwt $upstream_http_x_vouch_jwt;
  auth_request_set $auth_resp_err $upstream_http_x_vouch_err;
  auth_request_set $auth_resp_failcount $upstream_http_x_vouch_failcount;
}

error_page 401 = @error401;

location @error401 {
    # redirect to Vouch Proxy for login
    # return 302 http://localhost:9091/sso/login?url=$scheme://$http_host$request_uri&vouch-failcount=$auth_resp_failcount&X-Vouch-Token=$auth_resp_jwt&error=$auth_resp_err;
    # you usually *want* to redirect to Vouch running behind the same Nginx config proteced by https
    # but to get started you can just forward the end user to the port that vouch is running on
    return 302 http://localhost:9091/sso/login?url=$scheme://$http_host$request_uri&vouch-failcount=$auth_resp_failcount&X-Vouch-Token=$auth_resp_jwt&error=$auth_resp_err;
}


# # uncomment this to forward static content of vouch-proxy
# # used when running vouch-proxy with `testing: true`
location /static/ {
  proxy_set_header Host $http_host;
  proxy_pass http://vouch-gen:9090/static/;
}
