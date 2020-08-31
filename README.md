# grafana
Grafanaを使って、サーバのメトリクスを可視化する。

```.sh
# ビルド
docker build -t walk8243/grafana .

# 起動
docker run -id -p 3000:3000 walk8243/grafana:latest
```

Dockerコンテナが起動した後、 [Grafanaの管理画面](http://localhost:3000) にアクセスします。
なお、 `username` `password` ともに `admin` です。
