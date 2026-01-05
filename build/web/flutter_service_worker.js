'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "1057d13bdaa6d7a93bab32750fcb7246",
"assets/shaders/stretch_effect.frag": "40d68efbbf360632f614c731219e95f0",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "c0ad29d56cfe3890223c02da3c6e0448",
"assets/AssetManifest.bin.json": "d5c0b8e2938b7a6b3db68f83d9491b64",
"assets/assets/flappybird/sprites/message.png": "72e7d3f9bb4f432a695ff01d40d33cbf",
"assets/assets/flappybird/sprites/reset.png": "ed1a5313126e6fec4b05924464c7f00c",
"assets/assets/flappybird/sprites/6.png": "2f83f3e7822c527aef36b10a31016014",
"assets/assets/flappybird/sprites/background-day.png": "214a0a70e9ae043a415827cac6e18193",
"assets/assets/flappybird/sprites/yellowbird-downflap.png": "61d66249a632e9969a84185df653744f",
"assets/assets/flappybird/sprites/redbird-midflap.png": "1bbee40e926891f951f91f1446a55049",
"assets/assets/flappybird/sprites/8.png": "d64e73185bd186379940455f31f37260",
"assets/assets/flappybird/sprites/yellowbird-upflap.png": "67f0ce149ac4d00b46ea765d618abb1a",
"assets/assets/flappybird/sprites/pipe-red.png": "80743e0a858a40242e44a52412d5d0c2",
"assets/assets/flappybird/sprites/bluebird-downflap.png": "ee8f2d3e0fa616c06556aa4e810b6bcd",
"assets/assets/flappybird/sprites/3.png": "b73f7be20a8fd427e482f9984f568011",
"assets/assets/flappybird/sprites/9.png": "1a44893c7f28121adb3ec6d5f0d2b2b3",
"assets/assets/flappybird/sprites/2.png": "78a2df62beea26aaae3a0a6ff695f7ff",
"assets/assets/flappybird/sprites/redbird-upflap.png": "83efe8a4019704149fee5b96f5d9e60b",
"assets/assets/flappybird/sprites/1.png": "b46a47ffceba2529dbf2bbbee228add4",
"assets/assets/flappybird/sprites/background-night.png": "5a027c18138ca3a11035ff2a1f66d37d",
"assets/assets/flappybird/sprites/0.png": "c636bf4498a683512682b3aaf80a4e2c",
"assets/assets/flappybird/sprites/yellowbird-midflap.png": "82b392525fcd4a9f6ee0aede65d8cecc",
"assets/assets/flappybird/sprites/5.png": "0a3490755d329e9e3658baad44971cab",
"assets/assets/flappybird/sprites/bluebird-midflap.png": "fcb5a4cd9af8d50c15ccf3257399b968",
"assets/assets/flappybird/sprites/4.png": "c818536d8c23d6a08aa0dbd0fb7bc16d",
"assets/assets/flappybird/sprites/gameover.png": "b82eea6dbb4771dd5e9cd1cd7dc39648",
"assets/assets/flappybird/sprites/pipe-green.png": "69acf88fa7631d5c22c5ad29a1a67c49",
"assets/assets/flappybird/sprites/bluebird-upflap.png": "684493ce3b8e2b20eeec618b873ba4ab",
"assets/assets/flappybird/sprites/7.png": "eccba258c31f98d2e7ad4712510ba869",
"assets/assets/flappybird/sprites/redbird-downflap.png": "e0f983f73e49657589cf3c65637447d7",
"assets/assets/flappybird/sprites/base.png": "177b44c637520dc293a834c27a9d7778",
"assets/assets/flappybird/audios/hit.wav": "3cf321a7a65534a5abd59dc9aacae746",
"assets/assets/flappybird/audios/point.wav": "e1458a87070cab0b76f245fbcacc334b",
"assets/assets/flappybird/audios/wing.wav": "802e8685100ebd33c49630e01407641e",
"assets/assets/flappybird/audios/swoosh.wav": "db32166321ae7db58ff660306b04389a",
"assets/assets/flappybird/audios/die.wav": "16436c886c305a4bb2f8aa04e0e00919",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/AssetManifest.bin": "c290131d11dbd09036bc787e282fe2b2",
"assets/NOTICES": "00f320b7569dac1c0ba61248a376e232",
"manifest.json": "2a0b63f97af47e8d9fe6e5a041031c83",
"main.dart.js": "6949bb942fe96964274cf21d2c54f254",
"version.json": "cfb1e249a9a56f8f1644e08f9632c56b",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"index.html": "e72da2d2e3c6e4b7ef9535b85a02123d",
"/": "e72da2d2e3c6e4b7ef9535b85a02123d",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"canvaskit/canvaskit.js": "8331fe38e66b3a898c4f37648aaf7ee2",
"canvaskit/skwasm_heavy.wasm": "b0be7910760d205ea4e011458df6ee01",
"canvaskit/canvaskit.wasm": "9b6a7830bf26959b200594729d73538e",
"canvaskit/skwasm.js.symbols": "3a4aadf4e8141f284bd524976b1d6bdc",
"canvaskit/skwasm_heavy.js": "740d43a6b8240ef9e23eed8c48840da4",
"canvaskit/skwasm.js": "8060d46e9a4901ca9991edd3a26be4f0",
"canvaskit/skwasm_heavy.js.symbols": "0755b4fb399918388d71b59ad390b055",
"canvaskit/chromium/canvaskit.js": "a80c765aaa8af8645c9fb1aae53f9abf",
"canvaskit/chromium/canvaskit.wasm": "a726e3f75a84fcdf495a15817c63a35d",
"canvaskit/chromium/canvaskit.js.symbols": "e2d09f0e434bc118bf67dae526737d07",
"canvaskit/skwasm.wasm": "7e5f3afdd3b0747a1fd4517cea239898",
"canvaskit/canvaskit.js.symbols": "a3c9f77715b642d0437d9c275caba91e",
"flutter.js": "24bc71911b75b5f8135c949e27a2984e"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
