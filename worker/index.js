const IMG_NUMBER = 115;
const PAGE_DOMAIN = "static-taffy.page.dev";

addEventListener('fetch', event => {
  event.respondWith(handleRequest(event.request))
})

async function handleRequest(request) {
  // 随机选一张图片
  const randomImageNumber = Math.floor(Math.random() * IMG_NUMBER) + 1;
  const imageUrl = `${PAGE_DOMAIN}/${randomImageNumber}.png`;

  try {
    // 获取图片
    const imageResponse = await fetch(imageUrl);

    if (!imageResponse.ok) {
      throw new Error(`Failed to fetch image: ${imageResponse.status} ${imageResponse.statusText}`);
    }

    const contentType = imageResponse.headers.get('content-type') || 'image/png';

    // 响应
    return new Response(imageResponse.body, {
      status: imageResponse.status,
      statusText: imageResponse.statusText,
      headers: {
        'content-type': contentType,
        'Access-Control-Allow-Origin': '*', // CORS support
        'Cache-Control': 'public, max-age=86400' // Cache for 24 hours
      }
    });
  } catch (err) {
    return new Response(`Error fetching image: ${err.message}`, { 
      status: 500,
      headers: {
        'content-type': 'text/plain',
        'Access-Control-Allow-Origin': '*'
      }
    });
  }
}