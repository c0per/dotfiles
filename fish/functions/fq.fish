function fq
    set -xg http_proxy http://192.168.18.4:10870
    set -xg https_proxy http://192.168.18.4:10870
end

function dfq
    set -e http_proxy
    set -e https_proxy
end
