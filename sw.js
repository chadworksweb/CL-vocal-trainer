// Kill switch. The page no longer registers a service worker; this file exists
// only so any previously-installed Vocal Trainer worker updates to this version,
// drops its caches, unregisters itself, and reloads its pages. After that the tool
// is served straight from the network, so every reload shows the latest version.
// PWA/offline support can return once the tool has settled.
self.addEventListener('install', () => self.skipWaiting());

self.addEventListener('activate', (event) => {
  event.waitUntil((async () => {
    await self.clients.claim();
    const keys = await caches.keys();
    await Promise.all(keys.map((k) => caches.delete(k)));
    await self.registration.unregister();
    const clients = await self.clients.matchAll({ type: 'window' });
    clients.forEach((client) => client.navigate(client.url));
  })());
});
