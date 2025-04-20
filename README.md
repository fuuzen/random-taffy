# Random Taffy

托管到 Cloudflare 的提供随机 taffy 图片的 API。

1. 创建一个 Page 用于存放所有静态图片，监听目录和构建根目录都设置为仓库中存放这些图片的 `page` 目录。
2. 创建一个 Worker，名字要和 `wrangler.jsonc` 中的 `name` 属性一致，监听目录和构建根目录都设置为仓库中的 `worker` 目录。

也可以本地构建 Worker 上传部署：`cd worker && pnpx wrangler deploy`