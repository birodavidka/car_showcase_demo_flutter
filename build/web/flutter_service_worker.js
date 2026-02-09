'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "cc9b42d13242784fef7b8a3dff9c4e33",
"version.json": "fa7e6300d8a289c865991bf0006861a9",
"index.html": "acf9a27f21677c17b19fa9b1818dec2e",
"/": "acf9a27f21677c17b19fa9b1818dec2e",
"main.dart.js": "a0adc7bb153e18839d3b783b896cc278",
"flutter.js": "24bc71911b75b5f8135c949e27a2984e",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "5b1eaf486d1d2d33eb7e32c6c9605772",
"assets/NOTICES": "796d9c4fbd08b7770e8ba263bc4a3d72",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/AssetManifest.bin.json": "36a6dff26e48ab87569e82431b25dd26",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/shaders/stretch_effect.frag": "40d68efbbf360632f614c731219e95f0",
"assets/AssetManifest.bin": "2cdd706e365dc963a3564da835bb5cd5",
"assets/fonts/MaterialIcons-Regular.otf": "a7b759e5c0365f134c148ef8ca7d905f",
"assets/assets/images/bmwe39/IMG_8952.jpg": "83a11395b1d43208b6f4400fc5103055",
"assets/assets/images/bmwe39/IMG_8953.jpg": "c4cbd30702cfb2e7a28b2227fe429166",
"assets/assets/images/bmwe39/IMG_8955.jpg": "d6e03e91f968c71ef880e8b04dd7dda6",
"assets/assets/images/bmwe39/IMG_8951.jpeg": "16c6442516d4066b4a981bd00a9e1d59",
"assets/assets/images/bmwe39/IMG_8957.jpg": "c84216d412ca11676461ab9455954ea6",
"assets/assets/images/bmwe39/IMG_8763.jpeg": "c41f9271b2c6d9b96e9bdb27edb07bf1",
"assets/assets/images/bmwe39/IMG_8958.jpeg": "241f2df0b34021ae2fd72ab8f3fd666b",
"assets/assets/images/bmwe39/IMG_8762.jpeg": "fab9f960dd8c344a48b71ea3f80fb06f",
"assets/assets/images/bmwe90/IMG_1323.JPG": "5e08cebe75bcbdf28e96f6894ca5c071",
"assets/assets/images/bmwe90/IMG_1321.JPG": "f0eb9164a08bf9aa88bf580e6292ad44",
"assets/assets/images/bmwe90/IMG_1324.JPG": "6993e4f43472d4d3cee1e4ef2340624f",
"assets/assets/images/bmwe90/IMG_6743.jpeg": "13d88cf4f0560da8c7ca2d3e72ba35a0",
"assets/assets/images/bmwe90/IMG_6739.jpeg": "42cade7294da78f59c2b65f5ff4e28f2",
"assets/assets/images/bmwe90/IMG_6741.jpeg": "76eb45a0d2ef6e398c058bb526651f57",
"assets/assets/images/bmwe90/IMG_6740.jpeg": "84dcddce1040d2401b17d20ada34d900",
"assets/assets/images/bmwe90/IMG_6746.jpeg": "8f46034a22f22316bbfd7cd0d28f9675",
"assets/assets/icons/meter.svg": "ae5326396cd0725d32ee15089c915d20",
"assets/assets/icons/cons.svg": "b55913ac9c26eeb2cfcb9a6e7bdd0c75",
"assets/assets/icons/arrow_back.svg": "922b6d406cb022868d501c73ae86f30d",
"assets/assets/icons/fuel.svg": "a85c3c2927a7967cf3a27d04098c296a",
"assets/assets/icons/transmission.svg": "746c067ca40e4c3e4f814d6b03231d63",
"assets/assets/icons/engine.svg": "607548d695c8578351c62c00a39be2f7",
"assets/assets/icons/calendar.svg": "4caa3a22b14f1c5ebf57db3ee3c5284a",
"assets/assets/icons/pros.svg": "4c80d46a8693b547e40e6b40c3a96bd5",
"canvaskit/skwasm.js": "8060d46e9a4901ca9991edd3a26be4f0",
"canvaskit/skwasm_heavy.js": "740d43a6b8240ef9e23eed8c48840da4",
"canvaskit/skwasm.js.symbols": "3a4aadf4e8141f284bd524976b1d6bdc",
"canvaskit/canvaskit.js.symbols": "a3c9f77715b642d0437d9c275caba91e",
"canvaskit/skwasm_heavy.js.symbols": "0755b4fb399918388d71b59ad390b055",
"canvaskit/skwasm.wasm": "7e5f3afdd3b0747a1fd4517cea239898",
"canvaskit/chromium/canvaskit.js.symbols": "e2d09f0e434bc118bf67dae526737d07",
"canvaskit/chromium/canvaskit.js": "a80c765aaa8af8645c9fb1aae53f9abf",
"canvaskit/chromium/canvaskit.wasm": "a726e3f75a84fcdf495a15817c63a35d",
"canvaskit/canvaskit.js": "8331fe38e66b3a898c4f37648aaf7ee2",
"canvaskit/canvaskit.wasm": "9b6a7830bf26959b200594729d73538e",
"canvaskit/skwasm_heavy.wasm": "b0be7910760d205ea4e011458df6ee01"};
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
