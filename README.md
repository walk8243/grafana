# grafana
Grafanaをインストールする

```.sh
# ビルド
docker build -t walk8243/grafana .

# 起動
docker run -id -p 3000:3000 walk8243/grafana:latest
```
